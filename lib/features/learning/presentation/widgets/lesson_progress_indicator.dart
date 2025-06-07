import 'package:flutter/material.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../../../core/theme/app_theme.dart';

/// 课程进度指示器组件
/// 
/// 显示课程的学习进度、状态和相关统计信息
class LessonProgressIndicator extends StatelessWidget {
  final LessonEntity lesson;
  final bool showDetails; // 是否显示详细信息
  final VoidCallback? onProgressTap; // 进度点击回调
  
  const LessonProgressIndicator({
    super.key,
    required this.lesson,
    this.showDetails = true,
    this.onProgressTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 主要进度信息
        _buildMainProgress(context),
        
        if (showDetails) ...[
          const SizedBox(height: 20),
          
          // 详细统计信息
          _buildDetailedStats(context),
          
          const SizedBox(height: 16),
          
          // 学习历史
          _buildLearningHistory(context),
        ],
      ],
    );
  }
  
  /// 构建主要进度信息
  Widget _buildMainProgress(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getStatusColor(lesson.status).withValues(alpha: 0.1),
            _getStatusColor(lesson.status).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getStatusColor(lesson.status).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          // 状态和进度标题
          Row(
            children: [
              Icon(
                _getStatusIcon(lesson.status),
                color: _getStatusColor(lesson.status),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                _getStatusText(lesson.status),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(lesson.status),
                ),
              ),
              const Spacer(),
              Text(
                '${(lesson.progress * 100).toInt()}%',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(lesson.status),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // 进度条
          GestureDetector(
            onTap: onProgressTap,
            child: _buildProgressBar(context),
          ),
          
          const SizedBox(height: 12),
          
          // 进度描述
          Text(
            _getProgressDescription(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  /// 构建进度条
  Widget _buildProgressBar(BuildContext context) {
    return Container(
      height: 12,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          // 背景进度条
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          
          // 实际进度
          FractionallySizedBox(
            widthFactor: lesson.progress,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _getStatusColor(lesson.status),
                    _getStatusColor(lesson.status).withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: _getStatusColor(lesson.status).withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          
          // 进度指示器
          if (lesson.progress > 0)
            Positioned(
              left: (lesson.progress * MediaQuery.of(context).size.width * 0.8) - 6,
              top: 0,
              bottom: 0,
              child: Container(
                width: 12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _getStatusColor(lesson.status),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  /// 构建详细统计信息
  Widget _buildDetailedStats(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            title: '完成次数',
            value: '${lesson.completionCount}',
            icon: Icons.check_circle,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            title: '最佳分数',
            value: lesson.bestScore?.toString() ?? '--',
            icon: Icons.star,
            color: Colors.amber,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            title: '预计时长',
            value: '${lesson.estimatedDuration}分钟',
            icon: Icons.access_time,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
  
  /// 构建统计卡片
  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  /// 构建学习历史
  Widget _buildLearningHistory(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '学习历史',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 历史记录列表
          _buildHistoryItem(
            context,
            title: '创建时间',
            subtitle: _formatDate(lesson.createdAt),
            icon: Icons.play_arrow,
            color: Colors.blue,
          ),
          
          const SizedBox(height: 8),
          
          _buildHistoryItem(
            context,
            title: '最后更新',
            subtitle: _formatDate(lesson.updatedAt),
            icon: Icons.schedule,
            color: Colors.orange,
          ),
          
          if (lesson.isCompleted) ...[
            const SizedBox(height: 8),
            _buildHistoryItem(
              context,
              title: '完成状态',
              subtitle: '已完成',
              icon: Icons.check_circle,
              color: Colors.green,
            ),
          ]
        ],
      ),
    );
  }
  
  /// 构建历史记录项
  Widget _buildHistoryItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 16,
            color: color,
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
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
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
  
  // ==================== Helper Methods ====================
  
  /// 获取状态图标
  IconData _getStatusIcon(LessonStatus status) {
    switch (status) {
      case LessonStatus.notStarted:
        return Icons.play_circle_outline;
      case LessonStatus.inProgress:
        return Icons.play_arrow;
      case LessonStatus.completed:
        return Icons.check_circle;
      case LessonStatus.locked:
        return Icons.lock;
    }
  }
  
  /// 获取状态颜色
  Color _getStatusColor(LessonStatus status) {
    switch (status) {
      case LessonStatus.notStarted:
        return Colors.grey;
      case LessonStatus.inProgress:
        return AppColors.primary;
      case LessonStatus.completed:
        return Colors.green;
      case LessonStatus.locked:
        return Colors.red;
    }
  }
  
  /// 获取状态文本
  String _getStatusText(LessonStatus status) {
    switch (status) {
      case LessonStatus.notStarted:
        return '未开始';
      case LessonStatus.inProgress:
        return '学习中';
      case LessonStatus.completed:
        return '已完成';
      case LessonStatus.locked:
        return '未解锁';
    }
  }
  
  /// 获取进度描述
  String _getProgressDescription() {
    if (lesson.status == LessonStatus.completed) {
      return '恭喜！您已完成这个课程';
    } else if (lesson.status == LessonStatus.inProgress) {
      final remainingProgress = (1 - lesson.progress) * 100;
      return '还有 ${remainingProgress.toInt()}% 的内容等待学习';
    } else if (lesson.status == LessonStatus.locked) {
      return '完成前置课程后即可解锁';
    } else {
      return '点击开始按钮开始学习';
    }
  }
  
  /// 格式化日期
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return '刚刚';
        }
        return '${difference.inMinutes}分钟前';
      }
      return '${difference.inHours}小时前';
    } else if (difference.inDays == 1) {
      return '昨天';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
  }
}