import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/learning_bloc.dart';
import '../widgets/learning_header.dart';
import '../widgets/progress_overview.dart';
import '../widgets/recommended_lessons.dart';
import '../widgets/quick_actions.dart';
import '../widgets/learning_statistics.dart';
import '../../domain/entities/lesson_entity.dart';
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
      LoadLearningProgressEvent(widget.userId),
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
    if (state is LearningError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Theme.of(context).colorScheme.error,
          action: SnackBarAction(
            label: '重试',
            onPressed: _loadLearningData,
          ),
        ),
      );
    } else if (state is LearningOperationSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
      
      // 如果有特殊数据（如升级、成就），显示对话框
      if (state.data != null) {
        _showAchievementDialog(context, state.data!);
      }
    }
  }
  
  /// 构建主体内容
  Widget _buildBody(BuildContext context, LearningState state) {
    if (state is LearningInitial || state is LearningLoading) {
      return _buildLoadingView(state);
    } else if (state is LearningError) {
      return _buildErrorView(state);
    } else if (state is LearningLoaded) {
      return _buildLoadedView(context, state);
    }
    
    return const SizedBox.shrink();
  }
  
  /// 构建加载视图
  Widget _buildLoadingView(LearningState state) {
    String message = '正在加载...';
    if (state is LearningLoading && state.message != null) {
      message = state.message!;
    }
    
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
  Widget _buildErrorView(LearningError state) {
    return Center(
      child: CustomErrorWidget(
        message: state.message,
        onRetry: _loadLearningData,
      ),
    );
  }
  
  /// 构建已加载视图
  Widget _buildLoadedView(BuildContext context, LearningLoaded state) {
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
                progress: state.progress,
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
          _buildLearningTab(context, state),
          _buildProgressTab(context, state),
          _buildChallengeTab(context, state),
        ],
      ),
    );
  }
  
  /// 构建学习标签页
  Widget _buildLearningTab(BuildContext context, LearningLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 进度概览
          ProgressOverview(
            progress: state.progress,
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
            lessons: _getRecommendedLessons(state.lessons),
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
  Widget _buildProgressTab(BuildContext context, LearningLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          LearningStatistics(
            progress: state.progress,
            weeklyRecords: state.progress.weeklyStats,
            monthlyRecords: state.progress.weeklyStats,
            onViewDetailsTap: () => _navigateToDetailedStats(context),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
  
  /// 构建挑战标签页
  Widget _buildChallengeTab(BuildContext context, LearningLoaded state) {
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
      RefreshLearningDataEvent(widget.userId),
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
    final currentGoal = context.read<LearningBloc>().currentProgress?.dailyGoal ?? 30;
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
                UpdateDailyGoalEvent(
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
    // TODO: 导航到个人资料页面
  }
  
  void _navigateToSettings(BuildContext context) {
    // TODO: 导航到设置页面
  }
  
  void _navigateToSearch(BuildContext context) {
    // TODO: 导航到搜索页面
  }
  
  void _navigateToBookmarks(BuildContext context) {
    // TODO: 导航到收藏页面
  }
  
  void _navigateToLesson(BuildContext context, LessonEntity lesson) {
    // TODO: 导航到课程详情页面
  }
  
  void _navigateToAllLessons(BuildContext context) {
    // TODO: 导航到所有课程页面
  }
  
  void _navigateToDetailedStats(BuildContext context) {
    // TODO: 导航到详细统计页面
  }
  
}