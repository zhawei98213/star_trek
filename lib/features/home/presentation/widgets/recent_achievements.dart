import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// 最近成就组件
/// 显示用户最近获得的成就和徽章
class RecentAchievements extends StatelessWidget {
  const RecentAchievements({super.key});

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
              '最近成就',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: 导航到成就页面
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
        
        // 成就卡片
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingLarge),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
            boxShadow: AppTheme.cardShadow,
          ),
          child: Column(
            children: [
              // 最新成就
              _buildLatestAchievement(context),
              
              const SizedBox(height: AppTheme.spacingLarge),
              
              // 成就列表
              _buildAchievementsList(context),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建最新成就
  Widget _buildLatestAchievement(BuildContext context) {
    final latestAchievement = AchievementData(
      id: 'reading_master',
      title: '阅读大师',
      description: '连续7天完成阅读任务',
      icon: Icons.auto_stories,
      color: AppTheme.primaryColor,
      rarity: AchievementRarity.rare,
      unlockedAt: DateTime.now().subtract(const Duration(hours: 2)),
      points: 200,
    );
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            latestAchievement.color.withOpacity(0.1),
            latestAchievement.color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        border: Border.all(
          color: latestAchievement.color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // 新成就标签
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSmall,
                  vertical: AppTheme.spacingXSmall,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.successColor,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.new_releases,
                      color: Colors.white,
                      size: 14,
                    ),
                    const SizedBox(width: AppTheme.spacingXSmall),
                    Text(
                      '新成就',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                _formatTimeAgo(latestAchievement.unlockedAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacingMedium),
          
          // 成就内容
          Row(
            children: [
              // 成就图标
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: latestAchievement.color,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                  boxShadow: [
                    BoxShadow(
                      color: latestAchievement.color.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  latestAchievement.icon,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              
              const SizedBox(width: AppTheme.spacingLarge),
              
              // 成就信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          latestAchievement.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacingXSmall),
                        _buildRarityBadge(context, latestAchievement.rarity),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingXSmall),
                    Text(
                      latestAchievement.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingSmall),
                    Row(
                      children: [
                        const Icon(
                          Icons.stars,
                          color: AppTheme.secondaryColor,
                          size: 16,
                        ),
                        const SizedBox(width: AppTheme.spacingXSmall),
                        Text(
                          '+${latestAchievement.points} 积分',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建成就列表
  Widget _buildAchievementsList(BuildContext context) {
    final achievements = [
      AchievementData(
        id: 'vocabulary_100',
        title: '词汇达人',
        description: '学会100个新单词',
        icon: Icons.abc,
        color: AppTheme.warningColor,
        rarity: AchievementRarity.common,
        unlockedAt: DateTime.now().subtract(const Duration(days: 1)),
        points: 100,
      ),
      AchievementData(
        id: 'listening_streak',
        title: '听力专家',
        description: '连续5天完成听力练习',
        icon: Icons.headphones,
        color: AppTheme.successColor,
        rarity: AchievementRarity.uncommon,
        unlockedAt: DateTime.now().subtract(const Duration(days: 3)),
        points: 150,
      ),
      AchievementData(
        id: 'early_bird',
        title: '早起鸟儿',
        description: '早上8点前开始学习',
        icon: Icons.wb_sunny,
        color: AppTheme.secondaryColor,
        rarity: AchievementRarity.common,
        unlockedAt: DateTime.now().subtract(const Duration(days: 5)),
        points: 50,
      ),
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '近期解锁',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        
        const SizedBox(height: AppTheme.spacingMedium),
        
        // 成就网格
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppTheme.spacingMedium,
            mainAxisSpacing: AppTheme.spacingMedium,
            childAspectRatio: 1.0,
          ),
          itemCount: achievements.length,
          itemBuilder: (context, index) {
            return _buildAchievementItem(context, achievements[index]);
          },
        ),
      ],
    );
  }

  /// 构建成就项目
  Widget _buildAchievementItem(BuildContext context, AchievementData achievement) {
    return GestureDetector(
      onTap: () {
        _showAchievementDetails(context, achievement);
      },
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        decoration: BoxDecoration(
          color: achievement.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
          border: Border.all(
            color: achievement.color.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 成就图标
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: achievement.color,
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
              ),
              child: Icon(
                achievement.icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingSmall),
            
            // 成就标题
            Text(
              achievement.title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: AppTheme.spacingXSmall),
            
            // 稀有度标识
            _buildRarityBadge(context, achievement.rarity),
          ],
        ),
      ),
    );
  }

  /// 构建稀有度徽章
  Widget _buildRarityBadge(BuildContext context, AchievementRarity rarity) {
    Color color;
    String text;
    
    switch (rarity) {
      case AchievementRarity.common:
        color = Colors.grey;
        text = '普通';
        break;
      case AchievementRarity.uncommon:
        color = AppTheme.successColor;
        text = '稀有';
        break;
      case AchievementRarity.rare:
        color = AppTheme.primaryColor;
        text = '史诗';
        break;
      case AchievementRarity.legendary:
        color = AppTheme.secondaryColor;
        text = '传说';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingXSmall,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }

  /// 显示成就详情
  void _showAchievementDetails(BuildContext context, AchievementData achievement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 成就图标
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: achievement.color,
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                boxShadow: [
                  BoxShadow(
                    color: achievement.color.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                achievement.icon,
                color: Colors.white,
                size: 40,
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 成就信息
            Text(
              achievement.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: AppTheme.spacingSmall),
            
            Text(
              achievement.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: AppTheme.spacingMedium),
            
            // 奖励信息
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.stars,
                    color: AppTheme.secondaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: AppTheme.spacingXSmall),
                  Text(
                    '获得 ${achievement.points} 积分',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingMedium),
            
            Text(
              '解锁时间：${_formatDateTime(achievement.unlockedAt)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  /// 格式化时间差
  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }

  /// 格式化日期时间
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
           '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

/// 成就稀有度枚举
enum AchievementRarity {
  common,    // 普通
  uncommon,  // 稀有
  rare,      // 史诗
  legendary, // 传说
}

/// 成就数据模型
class AchievementData {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final AchievementRarity rarity;
  final DateTime unlockedAt;
  final int points;

  const AchievementData({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.rarity,
    required this.unlockedAt,
    required this.points,
  });
}