import 'package:flutter/material.dart';
import '../../domain/entities/learning_progress_entity.dart';
import '../../domain/entities/lesson_entity.dart';

/// 学习统计组件
/// 
/// 显示详细的学习数据、图表和趋势分析
class LearningStatistics extends StatelessWidget {
  final LearningProgressEntity progress;
  final List<DailyStudyRecord> weeklyRecords;
  final List<DailyStudyRecord> monthlyRecords;
  final VoidCallback? onViewDetailsTap;
  
  const LearningStatistics({
    super.key,
    required this.progress,
    required this.weeklyRecords,
    required this.monthlyRecords,
    this.onViewDetailsTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题栏
        _buildHeader(context),
        
        const SizedBox(height: 16),
        
        // 统计卡片
        _buildStatisticsCards(context),
        
        const SizedBox(height: 20),
        
        // 学习趋势图表
        _buildLearningChart(context),
        
        const SizedBox(height: 20),
        
        // 分类进度
        _buildCategoryProgress(context),
      ],
    );
  }
  
  /// 构建标题栏
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(
            Icons.analytics,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(
            '学习统计',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          if (onViewDetailsTap != null)
            TextButton(
              onPressed: onViewDetailsTap,
              child: Text(
                '查看详情',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  /// 构建统计卡片
  Widget _buildStatisticsCards(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildStatCard(
            context,
            title: '总学习时长',
            value: _formatStudyTime(progress.totalStudyTime),
            icon: Icons.access_time,
            color: Colors.blue,
            subtitle: '累计学习',
          ),
          
          const SizedBox(width: 16),
          
          _buildStatCard(
            context,
            title: '本周学习',
            value: _formatStudyTime(_getWeeklyStudyTime()),
            icon: Icons.calendar_view_week,
            color: Colors.green,
            subtitle: '${weeklyRecords.length}天',
          ),
          
          const SizedBox(width: 16),
          
          _buildStatCard(
            context,
            title: '连续学习',
            value: '${progress.currentStreak}',
            icon: Icons.local_fire_department,
            color: Colors.orange,
            subtitle: '天',
          ),
          
          const SizedBox(width: 16),
          
          _buildStatCard(
            context,
            title: '平均每日',
            value: _formatStudyTime(_getAverageDaily()),
            icon: Icons.trending_up,
            color: Colors.purple,
            subtitle: '学习时长',
          ),
        ],
      ),
    );
  }
  
  /// 构建统计卡片
  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String subtitle,
  }) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const Spacer(),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          
          const SizedBox(height: 4),
          
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
  
  /// 构建学习趋势图表
  Widget _buildLearningChart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '本周学习趋势',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '7天',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // 简化的柱状图
            _buildSimpleBarChart(context),
            
            const SizedBox(height: 16),
            
            // 图例
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(
                  context,
                  color: Theme.of(context).colorScheme.primary,
                  label: '学习时长（分钟）',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// 构建简化的柱状图
  Widget _buildSimpleBarChart(BuildContext context) {
    final maxStudyTime = weeklyRecords.isNotEmpty
        ? weeklyRecords.map((r) => r.studyTime).reduce((a, b) => a > b ? a : b)
        : 60;
    
    return SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(7, (index) {
          final dayName = _getDayName(index);
          final studyTime = index < weeklyRecords.length
              ? weeklyRecords[index].studyTime
              : 0;
          final height = maxStudyTime > 0
              ? (studyTime / maxStudyTime * 100).clamp(4.0, 100.0)
              : 4.0;
          
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 数值标签
              if (studyTime > 0)
                Text(
                  '$studyTime',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              
              const SizedBox(height: 4),
              
              // 柱子
              Container(
                width: 24,
                height: height,
                decoration: BoxDecoration(
                  color: studyTime > 0
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              
              const SizedBox(height: 8),
              
              // 日期标签
              Text(
                dayName,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
  
  /// 构建图例项
  Widget _buildLegendItem(
    BuildContext context, {
    required Color color,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
  
  /// 构建分类进度
  Widget _buildCategoryProgress(BuildContext context) {
    if (progress.categoryProgress.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '分类学习进度',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            ...progress.categoryProgress.values.map((category) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildCategoryItem(context, category),
              );
            }),
          ],
        ),
      ),
    );
  }
  
  /// 构建分类项
  Widget _buildCategoryItem(BuildContext context, CategoryProgress category) {
    final progressPercent = category.totalLessons > 0
        ? category.completedLessons / category.totalLessons
        : 0.0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _getCategoryName(category.type),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${category.completedLessons}/${category.totalLessons}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        LinearProgressIndicator(
          value: progressPercent,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
          minHeight: 6,
        ),
        
        const SizedBox(height: 4),
        
        Text(
          '${(progressPercent * 100).toInt()}% 完成',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
  
  // ==================== Helper Methods ====================
  
  /// 获取本周学习时长
  int _getWeeklyStudyTime() {
    return weeklyRecords.fold(0, (sum, record) => sum + record.studyTime);
  }
  
  /// 获取平均每日学习时长
  int _getAverageDaily() {
    if (monthlyRecords.isEmpty) return 0;
    final totalTime = monthlyRecords.fold(0, (sum, record) => sum + record.studyTime);
    return totalTime ~/ monthlyRecords.length;
  }
  
  /// 格式化学习时长
  String _formatStudyTime(int minutes) {
    if (minutes < 60) {
      return '$minutes分';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return '$hours小时';
      } else {
        return '${hours}h${remainingMinutes}m';
      }
    }
  }
  
  /// 获取星期名称
  String _getDayName(int index) {
    const days = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return days[index % 7];
  }
  
  /// 获取分类名称
  String _getCategoryName(LessonType type) {
    switch (type) {
      case LessonType.alphabet:
        return '字母学习';
      case LessonType.numbers:
        return '数字学习';
      case LessonType.shapes:
        return '形状学习';
      case LessonType.colors:
        return '颜色学习';
      case LessonType.animals:
        return '动物学习';
      case LessonType.vehicles:
        return '交通工具';
      case LessonType.food:
        return '食物学习';
      case LessonType.family:
        return '家庭成员';
      case LessonType.bodyParts:
        return '身体部位';
      case LessonType.dailyItems:
        return '日常用品';
      case LessonType.video:
        return '视频课程';
      case LessonType.interactive:
        return '交互式课程';
      case LessonType.quiz:
        return '测验课程';
      case LessonType.reading:
        return '阅读课程';
      case LessonType.game:
        return '游戏课程';
    }
  }
}