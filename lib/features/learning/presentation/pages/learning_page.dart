import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/learning_bloc.dart';
import '../bloc/learning_event.dart';
import '../bloc/learning_state.dart';
import '../widgets/learning_header.dart';
import '../widgets/progress_overview.dart';
import '../widgets/recommended_lessons.dart';
import '../widgets/quick_actions.dart';
import '../widgets/learning_statistics.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../domain/entities/learning_progress_entity.dart';
import '../../../home/presentation/widgets/daily_challenge.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/error_widget.dart';

/// 学习主页面
/// 
/// 展示用户的学习进度、推荐课程、最近学习等信息
class LearningPage extends StatefulWidget {
  final String userId;
  
  const LearningPage({
    super.key,
    required this.userId,
  });
  
  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    
    // 加载学习数据
    _loadLearningData();
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  void _loadLearningData() {
    context.read<LearningBloc>().add(
      LearningEvent.loadLearningProgress(widget.userId),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocConsumer<LearningBloc, LearningState>(
        listener: _handleStateChanges,
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: _buildBody(context, state),
          );
        },
      ),
    );
  }
  
  /// 处理状态变化
  void _handleStateChanges(BuildContext context, LearningState state) {
    state.maybeWhen(
      error: (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: Theme.of(context).colorScheme.error,
            action: SnackBarAction(
              label: '重试',
              onPressed: _loadLearningData,
            ),
          ),
        );
      },
      operationSuccess: (message, data) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        
        // 如果有特殊数据（如升级、成就），显示对话框
        if (data != null) {
          _showAchievementDialog(context, data);
        }
      },
      orElse: () {},
    );
  }
  
  /// 构建主体内容
  Widget _buildBody(BuildContext context, LearningState state) {
    return state.maybeWhen(
      initial: () => _buildLoadingView('正在初始化...'),
      loading: (message) => _buildLoadingView(message ?? '正在加载...'),
      error: (failure) => _buildErrorView(failure.message),
      loaded: (progress, lessons, searchResults, isSearching, searchQuery, completionResult) => 
        _buildLoadedView(context, progress, lessons),
      orElse: () => const SizedBox.shrink(),
    );
  }
  
  /// 构建加载视图
  Widget _buildLoadingView(String message) {
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LoadingWidget(),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
  
  /// 构建错误视图
  Widget _buildErrorView(String message) {
    return Center(
      child: CustomErrorWidget(
        message: message,
        onRetry: _loadLearningData,
      ),
    );
  }
  
  /// 构建已加载视图
  Widget _buildLoadedView(BuildContext context, LearningProgressEntity progress, List<LessonEntity> lessons) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: LearningHeader(
                progress: progress,
                onProfileTap: () => _navigateToProfile(context),
                onSettingsTap: () => _navigateToSettings(context),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: const [
                Tab(text: '学习', icon: Icon(Icons.school)),
                Tab(text: '进度', icon: Icon(Icons.analytics)),
                Tab(text: '挑战', icon: Icon(Icons.emoji_events)),
              ],
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLearningTab(context, progress, lessons),
          _buildProgressTab(context, progress, lessons),
          _buildChallengeTab(context, progress, lessons),
        ],
      ),
    );
  }
  
  /// 构建学习标签页
  Widget _buildLearningTab(BuildContext context, LearningProgressEntity progress, List<LessonEntity> lessons) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 进度概览
          ProgressOverview(
            progress: progress,
            onGoalTap: () => _showDailyGoalDialog(context),
          ),
          
          const SizedBox(height: 24),
          
          // 快速操作
          QuickActions(
            onSearchTap: () => _navigateToSearch(context),
            onBookmarksTap: () => _navigateToBookmarks(context),
          ),
          
          const SizedBox(height: 24),
          
          // 推荐课程
          RecommendedLessons(
            lessons: _getRecommendedLessons(lessons),
            onLessonTap: (lesson) => _navigateToLesson(context, lesson),
            onSeeAllTap: () => _navigateToAllLessons(context),
          ),
          
          const SizedBox(height: 24),
          
          const SizedBox(height: 100), // 底部间距
        ],
      ),
    );
  }
  
  /// 构建进度标签页
  Widget _buildProgressTab(BuildContext context, LearningProgressEntity progress, List<LessonEntity> lessons) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          LearningStatistics(
            progress: progress,
            weeklyRecords: progress.weeklyStats,
            monthlyRecords: progress.weeklyStats,
            onViewDetailsTap: () => _navigateToDetailedStats(context),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
  
  /// 构建挑战标签页
  Widget _buildChallengeTab(BuildContext context, LearningProgressEntity progress, List<LessonEntity> lessons) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const DailyChallenge(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
  
  // ==================== Helper Methods ====================
  
  /// 获取推荐课程
  List<LessonEntity> _getRecommendedLessons(List<LessonEntity> allLessons) {
    return allLessons
        .where((lesson) => 
            lesson.status == LessonStatus.notStarted ||
            lesson.status == LessonStatus.inProgress)
        .take(5)
        .toList();
  }
  

  
  /// 刷新数据
  Future<void> _onRefresh() async {
    context.read<LearningBloc>().add(
      LearningEvent.loadLearningProgress(widget.userId),
    );
    
    // 等待一段时间以确保刷新完成
    await Future.delayed(const Duration(seconds: 1));
  }
  
  /// 显示成就对话框
  void _showAchievementDialog(BuildContext context, Map<String, dynamic> data) {
    final pointsEarned = data['points_earned'] as int? ?? 0;
    final levelUp = data['level_up'] as bool? ?? false;
    final achievements = data['achievements'] as List<String>? ?? [];
    
    if (pointsEarned > 0 || levelUp || achievements.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('🎉 恭喜！'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (pointsEarned > 0)
                Text('获得 $pointsEarned 积分！'),
              if (levelUp)
                const Text('🎊 等级提升！'),
              if (achievements.isNotEmpty)
                ...achievements.map((achievement) => Text('🏆 解锁成就：$achievement')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('太棒了！'),
            ),
          ],
        ),
      );
    }
  }
  
  /// 显示每日目标对话框
  void _showDailyGoalDialog(BuildContext context) {
    final state = context.read<LearningBloc>().state;
    int currentGoal = 30; // 默认值
    state.maybeWhen(
      loaded: (progress, lessons, searchResults, isSearching, searchQuery, completionResult) {
        currentGoal = progress.dailyGoal;
      },
      orElse: () {},
    );
    double newGoal = currentGoal.toDouble();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('设置每日目标'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('当前目标：$currentGoal 分钟'),
            const SizedBox(height: 16),
            StatefulBuilder(
              builder: (context, setState) => Column(
                children: [
                  Slider(
                    value: newGoal,
                    min: 10,
                    max: 120,
                    divisions: 11,
                    label: '$newGoal 分钟',
                    onChanged: (value) {
                      setState(() {
                        newGoal = value.roundToDouble();
                      });
                    },
                  ),
                  Text('新目标：$newGoal 分钟'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              context.read<LearningBloc>().add(
                LearningEvent.updateDailyGoal(
                  userId: widget.userId,
                  goalMinutes: newGoal.round(),
                ),
              );
              Navigator.of(context).pop();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
  
  // ==================== Navigation Methods ====================
  
  void _navigateToProfile(BuildContext context) {
    context.go('/profile');
  }
  
  void _navigateToSettings(BuildContext context) {
    context.go('/settings');
  }
  
  void _navigateToSearch(BuildContext context) {
    context.go('/search');
  }
  
  void _navigateToBookmarks(BuildContext context) {
    context.go('/favorites');
  }
  
  void _navigateToLesson(BuildContext context, LessonEntity lesson) {
    context.go('/learning/default_user');
  }
  
  void _navigateToAllLessons(BuildContext context) {
    context.go('/learning/default_user');
  }
  
  void _navigateToDetailedStats(BuildContext context) {
    context.go('/statistics');
  }
  
}