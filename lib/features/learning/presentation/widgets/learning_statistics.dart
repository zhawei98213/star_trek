import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/learning_progress_entity.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../../../core/theme/app_theme.dart';

/// 成就数据类
class Achievement {
  final IconData icon;
  final String title;
  final String description;
  final String date;
  final Color color;
  
  Achievement({
    required this.icon,
    required this.title,
    required this.description,
    required this.date,
    required this.color,
  });
}

/// 徽章数据类
class _Badge {
  final IconData icon;
  final String name;
  final bool isEarned;
  final Color color;
  
  _Badge(this.icon, this.name, this.isEarned, this.color);
}

/// 里程碑数据类
class _Milestone {
  final String title;
  final String description;
  final bool isCompleted;
  final String completedDate;
  
  _Milestone(this.title, this.description, this.isCompleted, this.completedDate);
}

/// 学习统计组件
/// 
/// 显示详细的学习数据、图表和趋势分析
class LearningStatistics extends StatefulWidget {
  final LearningProgressEntity progress;
  final List<DailyStudyRecord> weeklyRecords;
  final List<DailyStudyRecord> monthlyRecords;
  final Map<String, dynamic>? statisticsData; // 额外的统计数据
  final VoidCallback? onViewDetailsTap;
  
  const LearningStatistics({
    super.key,
    required this.progress,
    required this.weeklyRecords,
    required this.monthlyRecords,
    this.statisticsData,
    this.onViewDetailsTap,
  });
  
  @override
  State<LearningStatistics> createState() => _LearningStatisticsState();
}

class _LearningStatisticsState extends State<LearningStatistics>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 统计概览卡片
        _buildOverviewCards(context),
        
        const SizedBox(height: 20),
        
        // 标签栏
        _buildTabBar(context),
        
        const SizedBox(height: 16),
        
        // 标签内容
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTimeAnalysis(context),
              _buildProgressAnalysis(context),
              _buildAchievements(context),
            ],
          ),
        ),
      ],
    );
  }
  
  /// 构建概览卡片
  Widget _buildOverviewCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildOverviewCard(
            context,
            icon: Icons.access_time,
            title: '总学习时长',
            value: '${widget.progress.totalStudyTime}分钟',
            subtitle: '本周 ${widget.progress.weeklyStats.fold(0, (sum, record) => sum + record.studyTime)}分钟',
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildOverviewCard(
            context,
            icon: Icons.local_fire_department,
            title: '连续学习',
            value: '${widget.progress.currentStreak}天',
            subtitle: '最长 ${widget.progress.longestStreak}天',
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildOverviewCard(
            context,
            icon: Icons.star,
            title: '总积分',
            value: '${widget.progress.totalPoints}',
            subtitle: '等级 ${widget.progress.currentLevel}',
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
  
  /// 构建概览卡片项
  Widget _buildOverviewCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          const SizedBox(height: 8),
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
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  /// 构建标签栏
  Widget _buildTabBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        tabs: const [
          Tab(text: '时间分析'),
          Tab(text: '进度分析'),
          Tab(text: '成就记录'),
        ],
      ),
    );
  }
  
  /// 构建时间分析
  Widget _buildTimeAnalysis(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 每日学习时间图表
          _buildDailyTimeChart(context),
          
          const SizedBox(height: 20),
          
          // 学习时间分布
          _buildTimeDistribution(context),
          
          const SizedBox(height: 20),
          
          // 学习习惯分析
          _buildStudyHabits(context),
        ],
      ),
    );
  }
  
  /// 构建每日学习时间图表
  Widget _buildDailyTimeChart(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '每日学习时间',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 20),
            
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 10,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withValues(alpha: 0.2),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const style = TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          );
                          final days = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
                          if (value.toInt() >= 0 && value.toInt() < days.length) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(days[value.toInt()], style: style),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            '${value.toInt()}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          );
                        },
                        reservedSize: 32,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.grey.withValues(alpha: 0.2),
                    ),
                  ),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 60,
                  lineBarsData: [
                    LineChartBarData(
                      spots: _generateWeeklyTimeSpots(),
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withValues(alpha: 0.3),
                        ],
                      ),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: AppColors.primary,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withValues(alpha: 0.3),
                            AppColors.primary.withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  

  
  /// 构建时间分布
  Widget _buildTimeDistribution(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '学习时间分布',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // 这里可以添加饼图或其他图表
            _buildSimpleBarChart(context),
          ],
        ),
      ),
    );
  }
  
  /// 构建学习习惯分析
  Widget _buildStudyHabits(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '学习习惯分析',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            _buildHabitItem(
              context,
              icon: Icons.schedule,
              title: '最佳学习时间',
              value: '上午 9:00-11:00',
              color: Colors.blue,
            ),
            
            const SizedBox(height: 12),
            
            _buildHabitItem(
              context,
              icon: Icons.timer,
              title: '平均学习时长',
              value: '${(widget.progress.totalStudyTime / (widget.progress.completedLessons > 0 ? widget.progress.completedLessons : 1)).round()}分钟',
              color: Colors.green,
            ),
            
            const SizedBox(height: 12),
            
            _buildHabitItem(
              context,
              icon: Icons.trending_up,
              title: '学习连续天数',
              value: '${widget.progress.currentStreak}天',
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
  
  /// 构建习惯项
  Widget _buildHabitItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
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
        
        const SizedBox(width: 12),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  /// 构建进度分析
  Widget _buildProgressAnalysis(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 总体进度
          _buildOverallProgress(context),
          
          const SizedBox(height: 20),
          
          // 分类进度
          _buildCategoryProgress(context),
          
          const SizedBox(height: 20),
          
          // 学习目标
          _buildLearningGoals(context),
        ],
      ),
    );
  }
  
  /// 构建总体进度
  Widget _buildOverallProgress(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '总体学习进度',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 20),
            
            Row(
              children: [
                Expanded(
                  child: _buildProgressCard(
                    context,
                    title: '已完成课程',
                    value: '${widget.progress.completedLessons}',
                    total: '${widget.progress.totalLessons}',
                    color: Colors.green,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                Expanded(
                  child: _buildProgressCard(
                    context,
                    title: '学习进度',
                    value: '${(widget.progress.overallProgress * 100).toInt()}%',
                    total: '',
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// 构建进度卡片
  Widget _buildProgressCard(
    BuildContext context, {
    required String title,
    required String value,
    required String total,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (total.isNotEmpty)
                Text(
                  '/$total',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: color.withValues(alpha: 0.7),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
  
  /// 构建分类进度
  Widget _buildCategoryProgress(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '分类学习进度',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 20),
            
            ...widget.progress.categoryProgress.values.map((category) =>
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildCategoryItem(context, category),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// 构建学习目标
  Widget _buildLearningGoals(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '学习目标',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 20),
            
            _buildGoalItem(
              context,
              title: '每日学习目标',
              current: widget.progress.todayStudyTime.toDouble(),
              target: widget.progress.dailyGoal.toDouble(),
              unit: '分钟',
            ),
            
            const SizedBox(height: 16),
            
            _buildGoalItem(
               context,
               title: '每周学习目标',
               current: widget.progress.weeklyStats.fold(0, (sum, record) => sum + record.studyTime).toDouble(),
               target: (widget.progress.dailyGoal * 7).toDouble(),
               unit: '分钟',
             ),
          ],
        ),
      ),
    );
  }
  
  /// 构建目标项
  Widget _buildGoalItem(
    BuildContext context, {
    required String title,
    required double current,
    required double target,
    required String unit,
  }) {
    final progress = (current / target).clamp(0.0, 1.0);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}% $unit',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
          minHeight: 6,
        ),
      ],
    );
  }
  
  /// 构建成就记录
  Widget _buildAchievements(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 最新成就
          _buildRecentAchievements(context),
          
          const SizedBox(height: 20),
          
          // 徽章收集
          _buildBadgeCollection(context),
          
          const SizedBox(height: 20),
          
          // 里程碑
          _buildMilestones(context),
        ],
      ),
    );
  }
  
  /// 构建最新成就
  Widget _buildRecentAchievements(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '最新成就',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // 模拟成就数据
             _buildAchievementItem(
               context,
               Achievement(
                 icon: Icons.star,
                 title: '连续学习7天',
                 description: '坚持每日学习，养成良好习惯',
                 date: '2024-01-15',
                 color: Colors.orange,
               ),
             ),
             const SizedBox(height: 12),
             _buildAchievementItem(
               context,
               Achievement(
                 icon: Icons.school,
                 title: '完成10个课程',
                 description: '学习进度稳步提升',
                 date: '2024-01-10',
                 color: Colors.blue,
               ),
             ),
          ],
        ),
      ),
    );
  }
  
  /// 构建成就项
   Widget _buildAchievementItem(BuildContext context, Achievement achievement) {
     return Row(
       children: [
         Container(
           width: 48,
           height: 48,
           decoration: BoxDecoration(
             color: achievement.color.withValues(alpha: 0.1),
             borderRadius: BorderRadius.circular(24),
             border: Border.all(
               color: achievement.color.withValues(alpha: 0.3),
             ),
           ),
           child: Icon(
             achievement.icon,
             color: achievement.color,
             size: 24,
           ),
         ),
         
         const SizedBox(width: 16),
         
         Expanded(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 achievement.title,
                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                   fontWeight: FontWeight.w600,
                 ),
               ),
               Text(
                 achievement.description,
                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
                   color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                 ),
               ),
             ],
           ),
         ),
         
         Text(
           achievement.date,
           style: Theme.of(context).textTheme.bodySmall?.copyWith(
             color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
           ),
         ),
       ],
     );
   }
  
  /// 构建徽章收集
  Widget _buildBadgeCollection(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '徽章收集',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 20),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 8, // 模拟8个徽章
               itemBuilder: (context, index) {
                 final badges = [
                   _Badge(Icons.star, '学习之星', true, Colors.orange),
                   _Badge(Icons.timer, '时间管理', true, Colors.blue),
                   _Badge(Icons.trending_up, '进步达人', false, Colors.green),
                   _Badge(Icons.school, '知识探索', true, Colors.purple),
                   _Badge(Icons.emoji_events, '成就收集', false, Colors.amber),
                   _Badge(Icons.flash_on, '学习闪电', false, Colors.red),
                   _Badge(Icons.favorite, '学习热爱', true, Colors.pink),
                   _Badge(Icons.psychology, '思维大师', false, Colors.indigo),
                 ];
                 return _buildBadgeItem(context, badges[index]);
               },
            ),
          ],
        ),
      ),
    );
  }
  
  /// 构建徽章项
   Widget _buildBadgeItem(BuildContext context, _Badge badge) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: badge.isEarned
                ? badge.color.withValues(alpha: 0.1)
                : Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: badge.isEarned
                  ? badge.color
                  : Colors.grey.withValues(alpha: 0.3),
            ),
          ),
          child: Icon(
            badge.icon,
            color: badge.isEarned ? badge.color : Colors.grey,
            size: 28,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          badge.name,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: badge.isEarned
                ? Theme.of(context).colorScheme.onSurface
                : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
  
  /// 构建里程碑
  Widget _buildMilestones(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '学习里程碑',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // 模拟里程碑数据
             _buildMilestoneItem(
               context,
               _Milestone('完成第一个课程', '开始你的学习之旅', true, '2024-01-01'),
             ),
             const SizedBox(height: 16),
             _buildMilestoneItem(
               context,
               _Milestone('连续学习7天', '养成良好的学习习惯', true, '2024-01-08'),
             ),
             const SizedBox(height: 16),
             _buildMilestoneItem(
               context,
               _Milestone('完成10个课程', '学习进度稳步提升', false, ''),
             ),
             const SizedBox(height: 16),
             _buildMilestoneItem(
               context,
               _Milestone('达到100小时学习时长', '成为学习达人', false, ''),
             ),
          ],
        ),
      ),
    );
  }
  
  /// 构建里程碑项
   Widget _buildMilestoneItem(BuildContext context, _Milestone milestone) {
     return Row(
       children: [
         Container(
           width: 12,
           height: 12,
           decoration: BoxDecoration(
             color: milestone.isCompleted
                 ? Theme.of(context).colorScheme.primary
                 : Colors.grey.withValues(alpha: 0.3),
             borderRadius: BorderRadius.circular(6),
           ),
         ),
         
         const SizedBox(width: 16),
         
         Expanded(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 milestone.title,
                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                   fontWeight: FontWeight.w600,
                   color: milestone.isCompleted
                       ? Theme.of(context).colorScheme.onSurface
                       : Colors.grey,
                 ),
               ),
               if (milestone.description.isNotEmpty)
                 Text(
                   milestone.description,
                   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                     color: milestone.isCompleted
                         ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)
                         : Colors.grey,
                   ),
                 ),
             ],
           ),
         ),
         
         if (milestone.isCompleted && milestone.completedDate.isNotEmpty)
           Text(
             milestone.completedDate,
             style: Theme.of(context).textTheme.bodySmall?.copyWith(
               color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
             ),
           ),
       ],
     );
   }
  
  /// 构建简化的柱状图
  Widget _buildSimpleBarChart(BuildContext context) {
    final maxStudyTime = widget.weeklyRecords.isNotEmpty
        ? widget.weeklyRecords.map((r) => r.studyTime).reduce((a, b) => a > b ? a : b)
        : 60;
    
    return SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(7, (index) {
          final dayName = _getDayName(index);
          final studyTime = index < widget.weeklyRecords.length
              ? widget.weeklyRecords[index].studyTime
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
  
  /// 生成每周学习时间数据点
  List<FlSpot> _generateWeeklyTimeSpots() {
    // 使用实际的每周记录数据
    if (widget.weeklyRecords.isNotEmpty) {
      return widget.weeklyRecords.asMap().entries.map((entry) {
        return FlSpot(entry.key.toDouble(), entry.value.studyTime.toDouble());
      }).toList();
    }
    
    // 模拟数据
    return [
      const FlSpot(0, 25), // 周一
      const FlSpot(1, 30), // 周二
      const FlSpot(2, 20), // 周三
      const FlSpot(3, 35), // 周四
      const FlSpot(4, 40), // 周五
      const FlSpot(5, 15), // 周六
      const FlSpot(6, 28), // 周日
    ];
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