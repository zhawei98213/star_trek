import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/learning_progress_entity.dart';
import '../../../../core/theme/app_theme.dart';

/// 增强版学习统计组件
/// 
/// 显示用户的学习统计数据，包括时间分布、进度分析、成就等
class LearningStatisticsEnhanced extends StatefulWidget {
  final LearningProgressEntity progress;
  final List<DailyStudyRecord> weeklyRecords;
  final List<DailyStudyRecord> monthlyRecords;
  final Map<String, dynamic>? statisticsData; // 额外的统计数据
  final VoidCallback? onViewDetailsTap;
  
  const LearningStatisticsEnhanced({
    super.key,
    required this.progress,
    required this.weeklyRecords,
    required this.monthlyRecords,
    this.statisticsData,
    this.onViewDetailsTap,
  });
  
  @override
  State<LearningStatisticsEnhanced> createState() => _LearningStatisticsEnhancedState();
}

class _LearningStatisticsEnhancedState extends State<LearningStatisticsEnhanced>
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
            
            Row(
              children: [
                // 饼图
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 150,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: _generateCategoryTimeData(),
                      ),
                    ),
                  ),
                ),
                
                // 图例
                Expanded(
                  flex: 3,
                  child: Column(
                    children: _buildCategoryLegend(context),
                  ),
                ),
              ],
            ),
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
              title: '平均学习时长',
              value: '${(widget.progress.totalStudyTime / 7).round()}分钟/天',
              description: '建议每天学习15-30分钟',
              color: Colors.blue,
            ),
            
            const SizedBox(height: 12),
            
            _buildHabitItem(
              context,
              icon: Icons.trending_up,
              title: '学习连续性',
              value: '${widget.progress.currentStreak}天连续',
              description: '保持良好的学习习惯',
              color: Colors.green,
            ),
            
            const SizedBox(height: 12),
            
            _buildHabitItem(
              context,
              icon: Icons.speed,
              title: '学习效率',
              value: '${_calculateEfficiency()}%',
              description: '完成度与时间的比值',
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
    required String description,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
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
          // 整体进度
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
  
  /// 构建整体进度
  Widget _buildOverallProgress(BuildContext context) {
    final completionRate = widget.progress.completedLessons / 
        (widget.progress.totalLessons > 0 ? widget.progress.totalLessons : 1);
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '整体学习进度',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // 圆形进度指示器
            Center(
              child: SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  children: [
                    CircularProgressIndicator(
                      value: completionRate,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey.withValues(alpha: 0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${(completionRate * 100).round()}%',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            '完成度',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // 进度详情
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProgressDetail(
                  context,
                  label: '已完成',
                  value: '${widget.progress.completedLessons}',
                  color: Colors.green,
                ),
                _buildProgressDetail(
                  context,
                  label: '进行中',
                  value: '${widget.progress.totalLessons - widget.progress.completedLessons}',
                  color: Colors.orange,
                ),
                _buildProgressDetail(
                  context,
                  label: '总课程',
                  value: '${widget.progress.totalLessons}',
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// 构建进度详情项
  Widget _buildProgressDetail(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
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
            
            const SizedBox(height: 16),
            
            ...widget.progress.categoryProgress.entries.map((entry) {
              final progress = entry.value;
              final completionRate = progress.completedLessons / 
                  (progress.totalLessons > 0 ? progress.totalLessons : 1);
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getCategoryDisplayName(entry.key.toString().split('.').last),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${progress.completedLessons}/${progress.totalLessons}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: completionRate,
                      backgroundColor: Colors.grey.withValues(alpha: 0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getCategoryColor(entry.key.toString().split('.').last),
                      ),
                    ),
                  ],
                ),
              );
            }),
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
            
            const SizedBox(height: 16),
            
            // 每日目标
            _buildGoalItem(
              context,
              icon: Icons.today,
              title: '每日学习目标',
              current: widget.progress.todayStudyTime,
              target: widget.progress.dailyGoal,
              unit: '分钟',
              color: Colors.blue,
            ),
            
            const SizedBox(height: 12),
            
            // 每周目标
            _buildGoalItem(
              context,
              icon: Icons.date_range,
              title: '每周学习目标',
              current: widget.progress.weeklyStats.fold(0, (sum, record) => sum + record.studyTime),
              target: widget.progress.dailyGoal * 7,
              unit: '分钟',
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
  
  /// 构建目标项
  Widget _buildGoalItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required int current,
    required int target,
    required String unit,
    required Color color,
  }) {
    final progress = target > 0 ? current / target : 0.0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              '$current/$target $unit',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress.clamp(0.0, 1.0),
          backgroundColor: Colors.grey.withValues(alpha: 0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }
  
  /// 构建成就记录
  Widget _buildAchievements(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 成就概览
          _buildAchievementOverview(context),
          
          const SizedBox(height: 20),
          
          // 最近成就
          _buildRecentAchievements(context),
          
          const SizedBox(height: 20),
          
          // 成就进度
          _buildAchievementProgress(context),
        ],
      ),
    );
  }
  
  /// 构建成就概览
  Widget _buildAchievementOverview(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '成就概览',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildAchievementStat(
                    context,
                    icon: Icons.emoji_events,
                    title: '获得成就',
                    value: '12',
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildAchievementStat(
                    context,
                    icon: Icons.military_tech,
                    title: '徽章收集',
                    value: '8',
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildAchievementStat(
                    context,
                    icon: Icons.workspace_premium,
                    title: '特殊奖励',
                    value: '3',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// 构建成就统计项
  Widget _buildAchievementStat(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
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
            title,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  /// 构建最近成就
  Widget _buildRecentAchievements(BuildContext context) {
    final achievements = _generateRecentAchievements();
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '最近获得',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            ...achievements.map((achievement) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: achievement.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        achievement.icon,
                        color: achievement.color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
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
                          const SizedBox(height: 2),
                          Text(
                            achievement.description,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
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
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
  
  /// 构建成就进度
  Widget _buildAchievementProgress(BuildContext context) {
    final progressAchievements = _generateProgressAchievements();
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '成就进度',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            ...progressAchievements.map((achievement) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          achievement.icon,
                          color: achievement.color,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            achievement.title,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          '${achievement.current}/${achievement.target}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: achievement.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: achievement.progress,
                      backgroundColor: Colors.grey.withValues(alpha: 0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(achievement.color),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
  
  // ==================== Helper Methods ====================
  
  /// 生成每周时间数据点
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
  
  /// 生成分类时间数据
  List<PieChartSectionData> _generateCategoryTimeData() {
    final categories = widget.progress.categoryProgress;
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];
    
    int colorIndex = 0;
    return categories.entries.map((entry) {
      final color = colors[colorIndex % colors.length];
      colorIndex++;
      
      return PieChartSectionData(
        color: color,
        value: entry.value.studyTime.toDouble(),
        title: '${entry.value.studyTime}min',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
  
  /// 构建分类图例
  List<Widget> _buildCategoryLegend(BuildContext context) {
    final categories = widget.progress.categoryProgress;
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];
    
    int colorIndex = 0;
    return categories.entries.map((entry) {
      final color = colors[colorIndex % colors.length];
      colorIndex++;
      
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _getCategoryDisplayName(entry.key.toString().split('.').last),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Text(
              '${entry.value.studyTime}min',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
  
  /// 计算学习效率
  int _calculateEfficiency() {
    if (widget.progress.totalStudyTime == 0) return 0;
    
    final completionRate = widget.progress.completedLessons / 
        (widget.progress.totalLessons > 0 ? widget.progress.totalLessons : 1);
    final timeEfficiency = completionRate * 100;
    
    return timeEfficiency.round();
  }
  
  /// 获取分类显示名称
  String _getCategoryDisplayName(String category) {
    switch (category) {
      case 'alphabet':
        return '字母学习';
      case 'numbers':
        return '数字学习';
      case 'colors':
        return '颜色认知';
      case 'shapes':
        return '形状认知';
      case 'animals':
        return '动物认知';
      case 'fruits':
        return '水果认知';
      default:
        return category;
    }
  }
  
  /// 获取分类颜色
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'alphabet':
        return Colors.blue;
      case 'numbers':
        return Colors.green;
      case 'colors':
        return Colors.purple;
      case 'shapes':
        return Colors.orange;
      case 'animals':
        return Colors.brown;
      case 'fruits':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  
  /// 生成最近成就
  List<Achievement> _generateRecentAchievements() {
    return [
      Achievement(
        icon: Icons.local_fire_department,
        title: '连续学习达人',
        description: '连续学习7天',
        date: '2天前',
        color: Colors.orange,
      ),
      Achievement(
        icon: Icons.star,
        title: '积分达人',
        description: '总积分达到1000',
        date: '5天前',
        color: Colors.amber,
      ),
      Achievement(
        icon: Icons.school,
        title: '课程完成者',
        description: '完成10个课程',
        date: '1周前',
        color: Colors.green,
      ),
    ];
  }
  
  /// 生成进度成就
  List<ProgressAchievement> _generateProgressAchievements() {
    return [
      ProgressAchievement(
        icon: Icons.access_time,
        title: '学习时长挑战',
        current: widget.progress.totalStudyTime,
        target: 1000,
        progress: widget.progress.totalStudyTime / 1000,
        color: Colors.blue,
      ),
      ProgressAchievement(
        icon: Icons.emoji_events,
        title: '课程完成挑战',
        current: widget.progress.completedLessons,
        target: 50,
        progress: widget.progress.completedLessons / 50,
        color: Colors.green,
      ),
      ProgressAchievement(
        icon: Icons.local_fire_department,
        title: '连续学习挑战',
        current: widget.progress.currentStreak,
        target: 30,
        progress: widget.progress.currentStreak / 30,
        color: Colors.orange,
      ),
    ];
  }
}

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

/// 进度成就数据类
class ProgressAchievement {
  final IconData icon;
  final String title;
  final int current;
  final int target;
  final double progress;
  final Color color;
  
  ProgressAchievement({
    required this.icon,
    required this.title,
    required this.current,
    required this.target,
    required this.progress,
    required this.color,
  });
}