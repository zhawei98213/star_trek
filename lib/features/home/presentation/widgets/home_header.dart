import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

/// 主页头部组件
/// 显示用户信息、欢迎消息和通知按钮
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppTheme.borderRadiusXLarge),
          bottomRight: Radius.circular(AppTheme.borderRadiusXLarge),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 顶部栏：用户头像和设置按钮
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 用户头像和信息
                  Row(
                    children: [
                      // 头像
                      GestureDetector(
                        onTap: () {
                        context.go('/profile');
                      },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: AppTheme.cardShadow,
                          ),
                          child: const Icon(
                            Icons.child_care,
                            color: AppTheme.primaryColor,
                            size: 28,
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: AppTheme.spacingMedium),
                      
                      // 用户信息
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '小探险家',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '等级 5 · 积分 1250',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  // 设置和通知按钮
                  Row(
                    children: [
                      // 通知按钮
                      IconButton(
                        onPressed: () {
                          // TODO: 显示通知列表
                          _showNotifications(context);
                        },
                        icon: Stack(
                          children: [
                            const Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                            // 红点提示
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppTheme.errorColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // 设置按钮
                      IconButton(
                        onPressed: () {
                        context.go('/settings');
                      },
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: AppTheme.spacingLarge),
              
              // 欢迎消息
              _buildWelcomeMessage(context),
              
              const SizedBox(height: AppTheme.spacingMedium),
              
              // 学习统计卡片
              _buildStatsCard(context),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建欢迎消息
  Widget _buildWelcomeMessage(BuildContext context) {
    final hour = DateTime.now().hour;
    String greeting;
    String message;
    
    if (hour < 12) {
      greeting = '早上好！';
      message = '新的一天，新的学习之旅开始了';
    } else if (hour < 18) {
      greeting = '下午好！';
      message = '继续你的英语学习冒险吧';
    } else {
      greeting = '晚上好！';
      message = '今天的学习任务完成了吗？';
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacingXSmall),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }

  /// 构建统计卡片
  Widget _buildStatsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // 今日学习时间
          Expanded(
            child: _buildStatItem(
              context,
              icon: Icons.access_time,
              label: '今日学习',
              value: '25分钟',
            ),
          ),
          
          // 分隔线
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          
          // 连续学习天数
          Expanded(
            child: _buildStatItem(
              context,
              icon: Icons.local_fire_department,
              label: '连续学习',
              value: '7天',
            ),
          ),
          
          // 分隔线
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          
          // 完成课程数
          Expanded(
            child: _buildStatItem(
              context,
              icon: Icons.check_circle,
              label: '完成课程',
              value: '12个',
            ),
          ),
        ],
      ),
    );
  }

  /// 构建统计项
  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(height: AppTheme.spacingXSmall),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  /// 显示通知列表
  void _showNotifications(BuildContext context) {
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
                '通知消息',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // 通知列表
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMedium,
              ),
              child: Column(
                children: [
                  _buildNotificationItem(
                    context,
                    title: '学习提醒',
                    message: '今天还没有完成学习任务哦！',
                    time: '2小时前',
                    isUnread: true,
                  ),
                  _buildNotificationItem(
                    context,
                    title: '新成就解锁',
                    message: '恭喜获得"连续学习7天"成就！',
                    time: '昨天',
                    isUnread: false,
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

  /// 构建通知项
  Widget _buildNotificationItem(
    BuildContext context, {
    required String title,
    required String message,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: isUnread
            ? AppTheme.primaryColor.withValues(alpha: 0.05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
        border: Border.all(
          color: AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // 未读指示器
          if (isUnread)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(right: AppTheme.spacingSmall),
              decoration: const BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          
          // 通知内容
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
                  message,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          
          // 时间
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textLightColor,
            ),
          ),
        ],
      ),
    );
  }
}