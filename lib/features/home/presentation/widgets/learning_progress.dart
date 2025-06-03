import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// 学习进度组件
/// 显示用户的学习进度和统计信息
class LearningProgress extends StatelessWidget {
  final VoidCallback? onViewDetailsTap;
  
  const LearningProgress({
    super.key,
    this.onViewDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题
        Text(
          '学习进度',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        
        const SizedBox(height: AppTheme.spacingMedium),
        
        // 进度卡片
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingLarge),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
            boxShadow: AppTheme.cardShadow,
          ),
          child: Column(
            children: [
              // 总体进度
              _buildOverallProgress(context),
              
              const SizedBox(height: AppTheme.spacingLarge),
              
              // 技能分类进度
              _buildSkillProgress(context),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建总体进度
  Widget _buildOverallProgress(BuildContext context) {
    const double progressValue = 0.65; // 65%的进度
    
    return Column(
      children: [
        // 进度环和统计
        Row(
          children: [
            // 圆形进度指示器
            SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                children: [
                  // 背景圆环
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: 1.0,
                      strokeWidth: 8,
                      backgroundColor: AppTheme.borderColor,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppTheme.borderColor,
                      ),
                    ),
                  ),
                  // 进度圆环
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: progressValue,
                      strokeWidth: 8,
                      backgroundColor: Colors.transparent,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  // 中心文字
                  Positioned.fill(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${(progressValue * 100).toInt()}%',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          Text(
                            '完成',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondaryColor,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: AppTheme.spacingLarge),
            
            // 统计信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '当前等级',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXSmall),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppTheme.warningColor,
                        size: 20,
                      ),
                      const SizedBox(width: AppTheme.spacingXSmall),
                      Text(
                        '初级探险家',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppTheme.spacingMedium),
                  
                  Text(
                    '下一等级还需',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXSmall),
                  Row(
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: AppTheme.secondaryColor,
                        size: 16,
                      ),
                      const SizedBox(width: AppTheme.spacingXSmall),
                      Text(
                        '350积分',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: AppTheme.spacingMedium),
        
        // 经验值进度条
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '经验值',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
                Text(
                  '1250 / 1600',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingXSmall),
            LinearProgressIndicator(
              value: 1250 / 1600,
              backgroundColor: AppTheme.borderColor,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppTheme.secondaryColor,
              ),
              minHeight: 6,
            ),
          ],
        ),
      ],
    );
  }

  /// 构建技能进度
  Widget _buildSkillProgress(BuildContext context) {
    final skills = [
      SkillProgress(
        name: '词汇',
        icon: Icons.abc,
        progress: 0.8,
        color: AppTheme.primaryColor,
        level: 'Lv.4',
      ),
      SkillProgress(
        name: '听力',
        icon: Icons.hearing,
        progress: 0.6,
        color: AppTheme.successColor,
        level: 'Lv.3',
      ),
      SkillProgress(
        name: '阅读',
        icon: Icons.menu_book,
        progress: 0.7,
        color: AppTheme.warningColor,
        level: 'Lv.3',
      ),
      SkillProgress(
        name: '口语',
        icon: Icons.record_voice_over,
        progress: 0.4,
        color: AppTheme.secondaryColor,
        level: 'Lv.2',
      ),
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '技能分析',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (onViewDetailsTap != null)
              TextButton(
                onPressed: onViewDetailsTap,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingSmall,
                    vertical: AppTheme.spacingXSmall,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '查看详情',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingXSmall),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: AppTheme.primaryColor,
                    ),
                  ],
                ),
              ),
          ],
        ),
        
        const SizedBox(height: AppTheme.spacingMedium),
        
        // 技能列表
        ...skills.map((skill) => _buildSkillItem(context, skill)),
      ],
    );
  }

  /// 构建技能项目
  Widget _buildSkillItem(BuildContext context, SkillProgress skill) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
      child: Row(
        children: [
          // 技能图标
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: skill.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
            ),
            child: Icon(
              skill.icon,
              color: skill.color,
              size: 20,
            ),
          ),
          
          const SizedBox(width: AppTheme.spacingMedium),
          
          // 技能信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      skill.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          skill.level,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: skill.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacingXSmall),
                        Text(
                          '${(skill.progress * 100).toInt()}%',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingXSmall),
                LinearProgressIndicator(
                  value: skill.progress,
                  backgroundColor: AppTheme.borderColor,
                  valueColor: AlwaysStoppedAnimation<Color>(skill.color),
                  minHeight: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 技能进度数据模型
class SkillProgress {
  final String name;
  final IconData icon;
  final double progress;
  final Color color;
  final String level;

  const SkillProgress({
    required this.name,
    required this.icon,
    required this.progress,
    required this.color,
    required this.level,
  });
}