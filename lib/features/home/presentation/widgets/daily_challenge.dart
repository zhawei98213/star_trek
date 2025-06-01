import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// 每日挑战组件
/// 显示当天的学习挑战任务
class DailyChallenge extends StatelessWidget {
  const DailyChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题和查看全部
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '今日挑战',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: 导航到挑战页面
              },
              child: Text(
                '查看全部',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: AppTheme.spacingMedium),
        
        // 挑战列表
        Column(
          children: [
            _buildChallengeCard(
              context,
              ChallengeData(
                title: '单词大师',
                description: '学习10个新单词',
                progress: 7,
                total: 10,
                reward: 50,
                icon: Icons.abc,
                color: AppTheme.primaryColor,
                isCompleted: false,
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingMedium),
            
            _buildChallengeCard(
              context,
              ChallengeData(
                title: '阅读达人',
                description: '完成2篇阅读理解',
                progress: 2,
                total: 2,
                reward: 80,
                icon: Icons.menu_book,
                color: AppTheme.successColor,
                isCompleted: true,
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingMedium),
            
            _buildChallengeCard(
              context,
              ChallengeData(
                title: '听力训练',
                description: '听音频练习15分钟',
                progress: 8,
                total: 15,
                reward: 30,
                icon: Icons.headphones,
                color: AppTheme.warningColor,
                isCompleted: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 构建挑战卡片
  Widget _buildChallengeCard(BuildContext context, ChallengeData challenge) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        boxShadow: AppTheme.cardShadow,
        border: challenge.isCompleted
            ? Border.all(color: AppTheme.successColor.withOpacity(0.3), width: 2)
            : null,
      ),
      child: Column(
        children: [
          // 头部信息
          Row(
            children: [
              // 挑战图标
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: challenge.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                ),
                child: Icon(
                  challenge.icon,
                  color: challenge.color,
                  size: 24,
                ),
              ),
              
              const SizedBox(width: AppTheme.spacingMedium),
              
              // 挑战信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          challenge.title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (challenge.isCompleted) ...[
                          const SizedBox(width: AppTheme.spacingXSmall),
                          const Icon(
                            Icons.check_circle,
                            color: AppTheme.successColor,
                            size: 20,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingXSmall),
                    Text(
                      challenge.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              // 奖励积分
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSmall,
                  vertical: AppTheme.spacingXSmall,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.stars,
                      color: AppTheme.secondaryColor,
                      size: 16,
                    ),
                    const SizedBox(width: AppTheme.spacingXSmall),
                    Text(
                      '+${challenge.reward}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacingMedium),
          
          // 进度条
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '进度',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                  Text(
                    '${challenge.progress}/${challenge.total}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: challenge.isCompleted 
                          ? AppTheme.successColor 
                          : AppTheme.textSecondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingXSmall),
              LinearProgressIndicator(
                value: challenge.progress / challenge.total,
                backgroundColor: AppTheme.borderColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  challenge.isCompleted ? AppTheme.successColor : challenge.color,
                ),
                minHeight: 6,
              ),
            ],
          ),
          
          // 操作按钮
          if (!challenge.isCompleted) ...[
            const SizedBox(height: AppTheme.spacingMedium),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _startChallenge(context, challenge);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: challenge.color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.spacingMedium,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                  ),
                ),
                child: Text(
                  '开始挑战',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ] else ...[
            const SizedBox(height: AppTheme.spacingMedium),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: AppTheme.spacingMedium,
              ),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                border: Border.all(
                  color: AppTheme.successColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppTheme.successColor,
                    size: 20,
                  ),
                  const SizedBox(width: AppTheme.spacingXSmall),
                  Text(
                    '挑战完成！',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 开始挑战
  void _startChallenge(BuildContext context, ChallengeData challenge) {
    // TODO: 根据挑战类型导航到相应的学习页面
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('开始挑战：${challenge.title}'),
        backgroundColor: challenge.color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
        ),
      ),
    );
  }
}

/// 挑战数据模型
class ChallengeData {
  final String title;
  final String description;
  final int progress;
  final int total;
  final int reward;
  final IconData icon;
  final Color color;
  final bool isCompleted;

  const ChallengeData({
    required this.title,
    required this.description,
    required this.progress,
    required this.total,
    required this.reward,
    required this.icon,
    required this.color,
    required this.isCompleted,
  });

  /// 计算完成百分比
  double get completionPercentage => progress / total;

  /// 是否接近完成（80%以上）
  bool get isNearCompletion => completionPercentage >= 0.8;
}