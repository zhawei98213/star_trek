import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// 快捷操作组件
/// 提供主要功能的快速入口
class QuickActions extends StatelessWidget {
  final VoidCallback? onLearningTap;
  
  const QuickActions({
    super.key,
    this.onLearningTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppTheme.spacingMedium,
          ),
          child: Text(
            '快速开始',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
            ),
          ),
        ),
        
        // 快捷操作网格
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppTheme.spacingMedium,
          crossAxisSpacing: AppTheme.spacingMedium,
          childAspectRatio: 1.5,
          children: [
            // 开始学习
            _buildActionCard(
              context,
              icon: Icons.play_circle_filled,
              title: '开始学习',
              subtitle: '继续你的英语之旅',
              color: AppTheme.primaryColor,
              gradient: AppTheme.primaryGradient,
              onTap: onLearningTap ?? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('课程页面开发中')),
                );
              },
            ),
            
            // 每日挑战
            _buildActionCard(
              context,
              icon: Icons.flash_on,
              title: '每日挑战',
              subtitle: '完成今日任务',
              color: AppTheme.secondaryColor,
              gradient: AppTheme.secondaryGradient,
              onTap: () => _showDailyChallenge(context),
            ),
            
            // 复习模式
            _buildActionCard(
              context,
              icon: Icons.refresh,
              title: '复习模式',
              subtitle: '巩固已学知识',
              color: AppTheme.successColor,
              gradient: AppTheme.successGradient,
              onTap: () => _showReviewMode(context),
            ),
            
            // 虚拟商店
            _buildActionCard(
              context,
              icon: Icons.store,
              title: '虚拟商店',
              subtitle: '使用积分购买道具',
              color: AppTheme.warningColor,
              gradient: const LinearGradient(
                colors: [AppTheme.warningColor, AppTheme.warningLightColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              onTap: () {
              // TODO: 导航到商店页面
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('商店页面开发中')),
              );
            },
            ),
          ],
        ),
      ],
    );
  }

  /// 构建操作卡片
  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required LinearGradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 图标
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadiusSmall,
                      ),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  
                  // 文本内容
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingXSmall),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 11,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 显示每日挑战
  void _showDailyChallenge(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
              ),
              child: const Icon(
                Icons.flash_on,
                color: AppTheme.secondaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: AppTheme.spacingMedium),
            const Text('每日挑战'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '今日挑战任务',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.spacingSmall),
            _buildChallengeItem(
              context,
              title: '完成3个单词学习',
              progress: 2,
              total: 3,
              isCompleted: false,
            ),
            _buildChallengeItem(
              context,
              title: '听力练习10分钟',
              progress: 10,
              total: 10,
              isCompleted: true,
            ),
            _buildChallengeItem(
              context,
              title: '完成1个阅读理解',
              progress: 0,
              total: 1,
              isCompleted: false,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('稍后完成'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: 导航到课程页面
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('课程页面开发中')),
            );
            },
            child: const Text('开始挑战'),
          ),
        ],
      ),
    );
  }

  /// 构建挑战项目
  Widget _buildChallengeItem(
    BuildContext context, {
    required String title,
    required int progress,
    required int total,
    required bool isCompleted,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
      padding: const EdgeInsets.all(AppTheme.spacingSmall),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppTheme.successColor.withValues(alpha: 0.1)
            : AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
        border: Border.all(
          color: isCompleted
              ? AppTheme.successColor.withValues(alpha: 0.3)
              : AppTheme.borderColor,
        ),
      ),
      child: Row(
        children: [
          // 完成状态图标
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? AppTheme.successColor : AppTheme.textLightColor,
            size: 20,
          ),
          
          const SizedBox(width: AppTheme.spacingSmall),
          
          // 任务信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXSmall),
                Text(
                  '$progress/$total',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 显示复习模式
  void _showReviewMode(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
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
            // 顶部指示器
            Container(
              margin: const EdgeInsets.only(top: AppTheme.spacingSmall),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // 标题
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Text(
                '选择复习内容',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // 复习选项
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMedium,
              ),
              child: Column(
                children: [
                  _buildReviewOption(
                    context,
                    icon: Icons.abc,
                    title: '单词复习',
                    subtitle: '复习已学过的单词',
                    onTap: () {
                      Navigator.of(context).pop();
                      // TODO: 跳转到单词复习页面
                    },
                  ),
                  _buildReviewOption(
                    context,
                    icon: Icons.hearing,
                    title: '听力复习',
                    subtitle: '重新练习听力内容',
                    onTap: () {
                      Navigator.of(context).pop();
                      // TODO: 跳转到听力复习页面
                    },
                  ),
                  _buildReviewOption(
                    context,
                    icon: Icons.menu_book,
                    title: '阅读复习',
                    subtitle: '重新阅读学过的文章',
                    onTap: () {
                      Navigator.of(context).pop();
                      // TODO: 跳转到阅读复习页面
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingLarge),
          ],
        ),
      ),
    );
  }

  /// 构建复习选项
  Widget _buildReviewOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.borderColor),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
        ),
        child: Row(
          children: [
            // 图标
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.successColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
              ),
              child: Icon(
                icon,
                color: AppTheme.successColor,
                size: 20,
              ),
            ),
            
            const SizedBox(width: AppTheme.spacingMedium),
            
            // 文本内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXSmall),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            
            // 箭头图标
            const Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.textLightColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}