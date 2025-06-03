import 'package:flutter/material.dart';
import '../../domain/entities/learning_progress_entity.dart';

/// 进度概览组件
/// 
/// 显示学习进度、每日目标、连续学习天数等关键信息
class ProgressOverview extends StatelessWidget {
  final LearningProgressEntity progress;
  final VoidCallback? onGoalTap;
  
  const ProgressOverview({
    super.key,
    required this.progress,
    this.onGoalTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '学习概览',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // 等级进度
            _buildLevelProgress(context),
            
            const SizedBox(height: 20),
            
            // 每日目标
            _buildDailyGoal(context),
            
            const SizedBox(height: 20),
            
            // 统计数据
            _buildStatsRow(context),
          ],
        ),
      ),
    );
  }
  
  /// 构建等级进度
  Widget _buildLevelProgress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '等级 ${progress.currentLevel}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${(progress.levelProgress * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        LinearProgressIndicator(
          value: progress.levelProgress,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
          minHeight: 8,
        ),
        
        const SizedBox(height: 4),
        
        Text(
          '距离下一级还需 ${_getPointsToNextLevel()} 积分',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
  
  /// 构建每日目标
  Widget _buildDailyGoal(BuildContext context) {
    final goalProgress = progress.todayStudyTime / progress.dailyGoal;
    final isGoalCompleted = goalProgress >= 1.0;
    
    return GestureDetector(
      onTap: onGoalTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isGoalCompleted
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isGoalCompleted ? Icons.check_circle : Icons.schedule,
                  color: isGoalCompleted
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 8),
                Text(
                  '今日目标',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (isGoalCompleted)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '已完成',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: goalProgress.clamp(0.0, 1.0),
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${progress.todayStudyTime}/${progress.dailyGoal}分钟',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// 构建统计数据行
  Widget _buildStatsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            context,
            icon: Icons.school,
            label: '已完成课程',
            value: '${progress.completedLessons}',
            color: Colors.blue,
          ),
        ),
        
        const SizedBox(width: 16),
        
        Expanded(
          child: _buildStatItem(
            context,
            icon: Icons.local_fire_department,
            label: '连续学习',
            value: '${progress.currentStreak}天',
            color: Colors.orange,
          ),
        ),
        
        const SizedBox(width: 16),
        
        Expanded(
          child: _buildStatItem(
            context,
            icon: Icons.access_time,
            label: '总学习时长',
            value: _formatStudyTime(progress.totalStudyTime),
            color: Colors.green,
          ),
        ),
      ],
    );
  }
  
  /// 构建统计项
  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  // ==================== Helper Methods ====================
  
  /// 获取到下一级所需积分
  int _getPointsToNextLevel() {
    const pointsPerLevel = 1000; // 这应该从常量中获取
    final pointsForNextLevel = (progress.currentLevel + 1) * pointsPerLevel;
    return pointsForNextLevel - progress.totalPoints;
  }
  
  /// 格式化学习时长
  String _formatStudyTime(int minutes) {
    if (minutes < 60) {
      return '$minutes分';
    } else if (minutes < 1440) {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return '$hours小时';
      } else {
        return '$hours小时$remainingMinutes分';
      }
    } else {
      final days = minutes ~/ 1440;
      final remainingHours = (minutes % 1440) ~/ 60;
      if (remainingHours == 0) {
        return '$days天';
      } else {
        return '$days天$remainingHours小时';
      }
    }
  }
}