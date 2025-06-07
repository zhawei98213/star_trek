import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../shared/widgets/bottom_navigation.dart';
import '../widgets/home_header.dart';
import '../widgets/quick_actions.dart';
import '../widgets/learning_progress.dart';
import '../widgets/daily_challenge.dart';
import '../widgets/recent_achievements.dart';
import '../bloc/home_bloc.dart';


/// 主页面
/// 应用的核心导航中心，展示学习进度、快捷操作等
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadUserData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// 初始化动画
  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  /// 加载用户数据
  void _loadUserData() {
    // 获取当前用户ID（这里使用默认用户ID，实际应用中应从认证系统获取）
    const String currentUserId = 'default_user';
    
    // 使用Bloc加载主页数据
    context.read<HomeBloc>().add(InitializeHomeEvent(currentUserId));
  }

  /// 刷新数据
  Future<void> _refreshData() async {
    const String currentUserId = 'default_user';
    context.read<HomeBloc>().add(RefreshHomeDataEvent(currentUserId));
  }
  


  @override
  Widget build(BuildContext context) {
    final isTabletLandscape = ResponsiveUtils.isTablet(context) && 
                             ResponsiveUtils.isLandscape(context);
    
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is HomeOperationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is NotificationUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('通知已更新 (${state.unreadCount} 条未读)'),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          builder: (context, state) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: isTabletLandscape 
                  ? _buildTabletLandscapeLayout(context, state)
                  : _buildMobileLayout(context, state),
            );
          },
        ),
      ),
      bottomNavigationBar: ResponsiveUtils.shouldShowSidebar(context) 
          ? null 
          : const AppBottomNavigation(currentIndex: 0),
    );
  }
  
  /// 构建移动端布局
  Widget _buildMobileLayout(BuildContext context, HomeState state) {
    if (state is HomeLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: AppTheme.spacingMedium),
            Text('加载中...'),
          ],
        ),
      );
    }
    
    return RefreshIndicator(
      onRefresh: _refreshData,
      color: AppTheme.primaryColor,
      child: CustomScrollView(
        slivers: [
          // 顶部头部区域
          SliverToBoxAdapter(
            child: const HomeHeader(),
          ),
          
          // 快捷操作区域
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.getHorizontalPadding(context),
              ),
              child: QuickActions(
              onLearningTap: () => context.go('/learning/default_user'),
            ),
            ),
          ),
          
          // 学习进度区域
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.getHorizontalPadding(context),
              ),
              child: LearningProgress(
                onViewDetailsTap: () => context.go('/learning/default_user'),
              ),
            ),
          ),
          
          // 每日挑战区域
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.getHorizontalPadding(context),
              ),
              child: const DailyChallenge(),
            ),
          ),
          
          // 最近成就区域
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.getHorizontalPadding(context),
              ),
              child: const RecentAchievements(),
            ),
          ),
          
          // 底部间距
          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.spacingXLarge),
          ),
        ],
      ),
    );
  }
  
  /// 构建平板横屏布局
  Widget _buildTabletLandscapeLayout(BuildContext context, HomeState state) {
    if (state is HomeLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: AppTheme.spacingMedium),
            Text('加载中...'),
          ],
        ),
      );
    }
    
    return Row(
      children: [
        // 左侧导航栏
        Container(
          width: ResponsiveUtils.getSidebarWidth(context),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(
                color: AppTheme.borderColor,
                width: 1,
              ),
            ),
          ),
          child: const _TabletSidebar(),
        ),
        
        // 主内容区域
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshData,
            color: AppTheme.primaryColor,
            child: CustomScrollView(
              slivers: [
                // 顶部头部区域（简化版）
                const SliverToBoxAdapter(
                  child: _TabletHeader(),
                ),
                
                // 主要内容区域
                SliverToBoxAdapter(
                  child: ResponsiveUtils.buildResponsiveContainer(
                    context: context,
                    child: Column(
                      children: [
                        // 快捷操作和学习进度并排显示
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 左侧：快捷操作
                            Expanded(
                              flex: 2,
                              child: QuickActions(
                onLearningTap: () => context.go('/learning/default_user'),
              ),
                            ),
                            const SizedBox(width: AppTheme.spacingLarge),
                            // 右侧：学习进度
                            Expanded(
                              flex: 1,
                              child: LearningProgress(
                                onViewDetailsTap: () => context.go('/learning'),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: AppTheme.spacingXLarge),
                        
                        // 每日挑战和成就并排显示
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: DailyChallenge(),
                            ),
                            const SizedBox(width: AppTheme.spacingLarge),
                            const Expanded(
                              child: RecentAchievements(),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: AppTheme.spacingXXLarge),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// 平板侧边栏组件
class _TabletSidebar extends StatelessWidget {
  const _TabletSidebar();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 用户信息区域
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingLarge),
          child: Column(
            children: [
              // 用户头像
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: AppTheme.cardShadow,
                ),
                child: const Icon(
                  Icons.child_care,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingMedium),
              
              // 用户名
              Text(
                '小探险家',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingSmall),
              
              // 等级信息
              Text(
                '等级 5 · 积分 1250',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
        
        const Divider(),
        
        // 导航菜单
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMedium,
            ),
            children: [
              _buildNavItem(
                context,
                icon: Icons.home,
                label: '首页',
                isSelected: true,
                onTap: () {
                  // 已经在首页，无需跳转
                },
              ),
              _buildNavItem(
                context,
                icon: Icons.school,
                label: '课程',
                onTap: () {
                  context.go('/learning/default_user');
                },
              ),
              _buildNavItem(
                context,
                icon: Icons.emoji_events,
                label: '成就',
                onTap: () {
                  context.go('/achievements');
                },
              ),
              _buildNavItem(
                context,
                icon: Icons.store,
                label: '商店',
                onTap: () {
                  context.go('/shop');
                },
              ),
              _buildNavItem(
                context,
                icon: Icons.settings,
                label: '设置',
                onTap: () {
                  context.go('/settings');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondaryColor,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimaryColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        selectedTileColor: AppTheme.primaryColor.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        ),
        onTap: onTap,
      ),
    );
  }
}

/// 平板头部组件
class _TabletHeader extends StatelessWidget {
  const _TabletHeader();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getHorizontalPadding(context),
        vertical: AppTheme.spacingLarge,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppTheme.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 欢迎信息
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '欢迎回来！',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '继续你的学习之旅',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ),
          
          // 操作按钮
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                tooltip: '搜索',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
                tooltip: '通知',
              ),
            ],
          ),
        ],
      ),
    );
  }
}