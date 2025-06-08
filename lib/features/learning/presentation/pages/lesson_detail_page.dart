import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../domain/usecases/get_lessons_usecase.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/learning_bloc.dart';
import '../bloc/learning_event.dart';
import '../../domain/usecases/update_lesson_progress_usecase.dart';

import '../bloc/learning_state.dart';

import '../widgets/lesson_content_widget.dart';
import '../widgets/lesson_progress_indicator.dart';
import '../widgets/lesson_actions.dart';
import '../widgets/lesson_info_card.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';

/// 课程详情页面
/// 
/// 显示课程的详细信息，包括内容、进度、操作等
class LessonDetailPage extends StatefulWidget {
  final String lessonId;
  final LessonEntity? lesson; // 可选的课程实体，用于快速显示
  
  const LessonDetailPage({
    super.key,
    required this.lessonId,
    this.lesson,
  });
  
  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage>
    with TickerProviderStateMixin {
  late final LearningBloc _learningBloc;
  late final TabController _tabController;
  late final ScrollController _scrollController;
  
  LessonEntity? _currentLesson;
  bool _isLoading = true;
  String? _error;
  
  @override
  void initState() {
    super.initState();
    _learningBloc = GetIt.instance<LearningBloc>();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    
    // 如果传入了课程实体，直接使用
    if (widget.lesson != null) {
      _currentLesson = widget.lesson;
      _isLoading = false;
    } else {
      // 否则加载课程详情
      _loadLessonDetail();
    }
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  /// 加载课程详情
  void _loadLessonDetail() {
    _learningBloc.add(LearningEvent.loadLessons(
      GetLessonsParams(
        ageGroup: null,
        difficulty: null,
        type: null,
      ),
    ));
  }
  
  /// 开始学习课程
  void _startLesson() {
    if (_currentLesson != null) {
      Navigator.of(context).pushNamed(
        '/lesson-learning',
        arguments: _currentLesson,
      );
    }
  }
  
  /// 继续学习课程
  void _continueLesson() {
    if (_currentLesson != null) {
      Navigator.of(context).pushNamed(
        '/lesson-learning',
        arguments: _currentLesson,
      );
    }
  }
  
  /// 重新学习课程
  void _restartLesson() {
    if (_currentLesson != null) {
      // 重置课程进度
      final params = UpdateProgressParams(
        userId: 'current_user_id', // TODO: 从用户状态获取实际用户ID
        lessonId: _currentLesson!.id,
        progress: 0.0,
        status: LessonStatus.notStarted,
        studyTime: 0,
      );
      _learningBloc.add(LearningEvent.updateLessonProgress(params));
      
      // 跳转到学习页面
      Navigator.of(context).pushNamed(
        '/lesson-learning',
        arguments: _currentLesson,
      );
    }
  }
  
  /// 收藏/取消收藏课程
  void _toggleBookmark() {
    if (_currentLesson != null) {
      _learningBloc.add(LearningEvent.toggleLessonBookmark(_currentLesson!.id));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LearningBloc, LearningState>(
        bloc: _learningBloc,
        listener: (context, state) {
          state.maybeWhen(
            loaded: (progress, lessons, searchResults, isSearching, searchQuery, completionResult) {
              // 更新课程信息
              final lesson = lessons.firstWhere(
                (l) => l.id == widget.lessonId,
                orElse: () => _currentLesson!,
              );
              setState(() {
                _currentLesson = lesson;
                _isLoading = false;
                _error = null;
              });
            },
            error: (failure) {
              setState(() {
                _error = failure.message;
                _isLoading = false;
              });
            },
            orElse: () {},
          );
        },
        child: _buildBody(),
      ),
    );
  }
  
  /// 构建页面主体
  Widget _buildBody() {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: LoadingWidget()),
      );
    }
    
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('课程详情'),
        ),
        body: Center(
          child: CustomErrorWidget(
            message: _error!,
            onRetry: _loadLessonDetail,
          ),
        ),
      );
    }
    
    if (_currentLesson == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('课程详情'),
        ),
        body: const Center(
          child: Text('课程不存在'),
        ),
      );
    }
    
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          _buildSliverAppBar(),
          _buildSliverTabBar(),
        ];
      },
      body: _buildTabBarView(),
    );
  }
  
  /// 构建可折叠的应用栏
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          _currentLesson!.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 3,
                color: Colors.black26,
              ),
            ],
          ),
        ),
        background: _buildLessonHeader(),
      ),
      actions: [
        IconButton(
          icon: Icon(
            _currentLesson!.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: _currentLesson!.isBookmarked ? AppColors.primary : null,
          ),
          onPressed: _toggleBookmark,
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            // 分享课程
          },
        ),
      ],
    );
  }
  
  /// 构建课程头部
  Widget _buildLessonHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _getDifficultyColor(_currentLesson!.difficulty).withValues(alpha: 0.8),
            _getDifficultyColor(_currentLesson!.difficulty).withValues(alpha: 0.6),
          ],
        ),
      ),
      child: Stack(
        children: [
          // 背景图片
          if (_currentLesson!.coverImageUrl != null)
            Positioned.fill(
              child: Image.network(
                _currentLesson!.coverImageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: _getDifficultyColor(_currentLesson!.difficulty),
                  );
                },
              ),
            ),
          
          // 渐变遮罩
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
          ),
          
          // 课程信息
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 课程类型和难度标签
                Row(
                  children: [
                    _buildTypeChip(_currentLesson!.type),
                    const SizedBox(width: 8),
                    _buildDifficultyChip(_currentLesson!.difficulty),
                    const SizedBox(width: 8),
                    _buildAgeGroupChip(_currentLesson!.ageGroup),
                  ],
                ),
                const SizedBox(height: 12),
                
                // 课程描述
                Text(
                  _currentLesson!.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  /// 构建标签页栏
  Widget _buildSliverTabBar() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverTabBarDelegate(
        TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: '课程内容'),
            Tab(text: '学习进度'),
            Tab(text: '相关信息'),
          ],
        ),
      ),
    );
  }
  
  /// 构建标签页视图
  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildContentTab(),
        _buildProgressTab(),
        _buildInfoTab(),
      ],
    );
  }
  
  /// 构建内容标签页
  Widget _buildContentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 课程内容列表
          LessonContentWidget(
            contents: _currentLesson!.contents,
            onContentTap: (content) {
              // 跳转到具体内容
            },
          ),
          
          const SizedBox(height: 20),
          
          // 学习操作按钮
          LessonActions(
            lesson: _currentLesson!,
            onStart: _startLesson,
            onContinue: _continueLesson,
            onRestart: _restartLesson,
          ),
        ],
      ),
    );
  }
  
  /// 构建进度标签页
  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 进度指示器
          LessonProgressIndicator(
            lesson: _currentLesson!,
          ),
          
          const SizedBox(height: 20),
          
          // 学习统计
          _buildLearningStats(),
        ],
      ),
    );
  }
  
  /// 构建信息标签页
  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 课程信息卡片
          LessonInfoCard(
            lesson: _currentLesson!,
          ),
          
          const SizedBox(height: 20),
          
          // 相关课程推荐
          _buildRelatedLessons(),
        ],
      ),
    );
  }
  
  /// 构建学习统计
  Widget _buildLearningStats() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '学习统计',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    '完成次数',
                    '${_currentLesson!.completionCount}',
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    '最佳分数',
                    _currentLesson!.bestScore?.toString() ?? '--',
                    Icons.star,
                    Colors.amber,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    '学习进度',
                    '${(_currentLesson!.progress * 100).toInt()}%',
                    Icons.trending_up,
                    Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// 构建统计项
  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  
  /// 构建相关课程
  Widget _buildRelatedLessons() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '相关课程',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // 这里可以显示相关课程列表
            const Text('暂无相关课程'),
          ],
        ),
      ),
    );
  }
  
  /// 构建类型标签
  Widget _buildTypeChip(LessonType type) {
    return Chip(
      label: Text(
        _getLessonTypeText(type),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: _getLessonTypeColor(type),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
  
  /// 构建难度标签
  Widget _buildDifficultyChip(DifficultyLevel difficulty) {
    return Chip(
      label: Text(
        _getDifficultyText(difficulty),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: _getDifficultyColor(difficulty),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
  
  /// 构建年龄组标签
  Widget _buildAgeGroupChip(AgeGroup ageGroup) {
    return Chip(
      label: Text(
        _getAgeGroupText(ageGroup),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: Colors.grey[600],
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
  
  /// 获取课程类型文本
  String _getLessonTypeText(LessonType type) {
    switch (type) {
      case LessonType.alphabet:
        return '字母';
      case LessonType.numbers:
        return '数字';
      case LessonType.shapes:
        return '形状';
      case LessonType.colors:
        return '颜色';
      case LessonType.animals:
        return '动物';
      case LessonType.vehicles:
        return '交通工具';
      case LessonType.food:
        return '食物';
      case LessonType.family:
        return '家庭成员';
      case LessonType.bodyParts:
        return '身体部位';
      case LessonType.dailyItems:
        return '日常用品';
      case LessonType.video:
        return '视频课程';
      case LessonType.interactive:
        return '交互式课程';
      case LessonType.quiz:
        return '测验课程';
      case LessonType.reading:
        return '阅读课程';
      case LessonType.game:
        return '游戏课程';
    }
  }
  
  /// 获取课程类型颜色
  Color _getLessonTypeColor(LessonType type) {
    switch (type) {
      case LessonType.alphabet:
        return Colors.blue;
      case LessonType.numbers:
        return Colors.green;
      case LessonType.shapes:
        return Colors.orange;
      case LessonType.colors:
        return Colors.purple;
      case LessonType.animals:
        return Colors.brown;
      case LessonType.vehicles:
        return Colors.indigo;
      case LessonType.food:
        return Colors.red;
      case LessonType.family:
        return Colors.lightGreen;
      case LessonType.bodyParts:
        return Colors.amber;
      case LessonType.dailyItems:
        return Colors.cyan;
      case LessonType.video:
        return Colors.pink;
      case LessonType.interactive:
        return Colors.lightBlue;
      case LessonType.quiz:
        return Colors.deepOrange;
      case LessonType.reading:
        return Colors.deepPurple;
      case LessonType.game:
        return Colors.lime;
    }
  }
  
  /// 获取难度文本
  String _getDifficultyText(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return '初级';
      case DifficultyLevel.intermediate:
        return '中级';
      case DifficultyLevel.advanced:
        return '高级';
    }
  }
  
  /// 获取难度颜色
  Color _getDifficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return Colors.green;
      case DifficultyLevel.intermediate:
        return Colors.orange;
      case DifficultyLevel.advanced:
        return Colors.red;
    }
  }
  
  /// 获取年龄组文本
  String _getAgeGroupText(AgeGroup ageGroup) {
    switch (ageGroup) {
      case AgeGroup.preschool:
        return '3-5岁';
      case AgeGroup.elementary:
        return '6-8岁';
      case AgeGroup.middle:
        return '9-12岁';
    }
  }
}

/// 自定义标签栏代理
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  
  _SliverTabBarDelegate(this._tabBar);
  
  @override
  double get minExtent => _tabBar.preferredSize.height;
  
  @override
  double get maxExtent => _tabBar.preferredSize.height;
  
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }
  
  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}

/// 扩展LessonEntity以支持收藏状态