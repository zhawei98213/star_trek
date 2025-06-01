import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/bottom_navigation.dart';
import '../widgets/home_header.dart';
import '../widgets/quick_actions.dart';
import '../widgets/learning_progress.dart';
import '../widgets/daily_challenge.dart';
import '../widgets/recent_achievements.dart';

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
  Future<void> _loadUserData() async {
    // TODO: 实现用户数据加载逻辑
    // 从本地存储或服务器获取用户信息、学习进度等
  }

  /// 刷新数据
  Future<void> _refreshData() async {
    await _loadUserData();
    // 显示刷新完成提示
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('数据已更新'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: RefreshIndicator(
            onRefresh: _refreshData,
            color: AppTheme.primaryColor,
            child: CustomScrollView(
              slivers: [
                // 顶部头部区域
                const SliverToBoxAdapter(
                  child: HomeHeader(),
                ),
                
                // 快捷操作区域
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMedium,
                    ),
                    child: QuickActions(),
                  ),
                ),
                
                // 学习进度区域
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingLarge,
                    ),
                    child: LearningProgress(),
                  ),
                ),
                
                // 每日挑战区域
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingLarge,
                    ),
                    child: DailyChallenge(),
                  ),
                ),
                
                // 最近成就区域
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingLarge,
                    ),
                    child: RecentAchievements(),
                  ),
                ),
                
                // 底部间距
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppTheme.spacingXLarge),
                ),
              ],
            ),
          ),
        ),
      ),
      
      // 底部导航栏
      bottomNavigationBar: const AppBottomNavigationWithFAB(
        currentIndex: 0, // 首页索引
      ),
    );
  }


}