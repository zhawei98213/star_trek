import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

/// 底部导航栏组件
/// 提供主要页面之间的导航功能
class AppBottomNavigation extends StatelessWidget {
  /// 当前选中的索引
  final int currentIndex;
  
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingMedium,
            vertical: AppTheme.spacingSmall,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                index: 0,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: '首页',
                route: '/home',
              ),
              _buildNavItem(
                context,
                index: 1,
                icon: Icons.school_outlined,
                activeIcon: Icons.school,
                label: '课程',
                route: '/courses',
              ),
              _buildNavItem(
                context,
                index: 2,
                icon: Icons.emoji_events_outlined,
                activeIcon: Icons.emoji_events,
                label: '成就',
                route: '/achievements',
              ),
              _buildNavItem(
                context,
                index: 3,
                icon: Icons.store_outlined,
                activeIcon: Icons.store,
                label: '商店',
                route: '/shop',
              ),
              _buildNavItem(
                context,
                index: 4,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: '我的',
                route: '/profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建导航项目
  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required String route,
  }) {
    final isSelected = currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          context.go(route);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMedium,
          vertical: AppTheme.spacingSmall,
        ),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppTheme.primaryColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 图标
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isSelected ? activeIcon : icon,
                key: ValueKey(isSelected),
                color: isSelected 
                    ? AppTheme.primaryColor 
                    : AppTheme.textSecondaryColor,
                size: 24,
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingXSmall),
            
            // 标签
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: isSelected 
                    ? AppTheme.primaryColor 
                    : AppTheme.textSecondaryColor,
                fontWeight: isSelected 
                    ? FontWeight.w600 
                    : FontWeight.normal,
                fontSize: 12,
              ),
              child: Text(label),
            ),
            
            // 选中指示器
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(top: AppTheme.spacingXSmall),
              width: isSelected ? 20 : 0,
              height: 2,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 带浮动操作按钮的底部导航栏
class AppBottomNavigationWithFAB extends StatelessWidget {
  /// 当前选中的索引
  final int currentIndex;
  
  /// 浮动操作按钮点击回调
  final VoidCallback? onFABPressed;
  
  const AppBottomNavigationWithFAB({
    super.key,
    required this.currentIndex,
    this.onFABPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 底部导航栏
        AppBottomNavigation(currentIndex: currentIndex),
        
        // 浮动操作按钮
        Positioned(
          top: -28,
          left: MediaQuery.of(context).size.width / 2 - 28,
          child: _buildFloatingActionButton(context),
        ),
      ],
    );
  }

  /// 构建浮动操作按钮
  Widget _buildFloatingActionButton(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(
              (AppTheme.primaryColor.r * 255.0).round() & 0xff,
              (AppTheme.primaryColor.g * 255.0).round() & 0xff, 
              (AppTheme.primaryColor.b * 255.0).round() & 0xff,
              0.3
            ),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onFABPressed ?? () {
            _showQuickActions(context);
          },
          borderRadius: BorderRadius.circular(28),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }

  /// 显示快捷操作菜单
  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacingLarge),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppTheme.borderRadiusLarge),
            topRight: Radius.circular(AppTheme.borderRadiusLarge),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 拖拽指示器
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 标题
            Text(
              '快捷操作',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 操作按钮网格
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: AppTheme.spacingMedium,
              mainAxisSpacing: AppTheme.spacingMedium,
              childAspectRatio: 1.0,
              children: [
                _buildQuickActionItem(
                  context,
                  icon: Icons.play_circle_outline,
                  label: '开始学习',
                  color: AppTheme.primaryColor,
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/courses');
                  },
                ),
                _buildQuickActionItem(
                  context,
                  icon: Icons.quiz_outlined,
                  label: '每日挑战',
                  color: AppTheme.warningColor,
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/challenge');
                  },
                ),
                _buildQuickActionItem(
                  context,
                  icon: Icons.refresh,
                  label: '复习模式',
                  color: AppTheme.successColor,
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/review');
                  },
                ),
                _buildQuickActionItem(
                  context,
                  icon: Icons.store,
                  label: '虚拟商店',
                  color: AppTheme.secondaryColor,
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/shop');
                  },
                ),
                _buildQuickActionItem(
                  context,
                  icon: Icons.emoji_events,
                  label: '我的成就',
                  color: AppTheme.primaryColor,
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/achievements');
                  },
                ),
                _buildQuickActionItem(
                  context,
                  icon: Icons.settings,
                  label: '设置',
                  color: Colors.grey,
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/settings');
                  },
                ),
              ],
            ),
            
            const SizedBox(height: AppTheme.spacingLarge),
          ],
        ),
      ),
    );
  }

  /// 构建快捷操作项目
  Widget _buildQuickActionItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: AppTheme.spacingSmall),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}