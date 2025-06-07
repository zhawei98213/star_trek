import 'package:flutter/material.dart';
import '../../domain/entities/lesson_entity.dart';

/// 课程卡片组件
/// 
/// 显示课程的基本信息和进度
class LessonCard extends StatelessWidget {
  /// 课程实体
  final LessonEntity lesson;
  
  /// 点击回调
  final VoidCallback? onTap;
  
  /// 是否显示进度
  final bool showProgress;
  
  /// 是否紧凑模式
  final bool isCompact;
  
  const LessonCard({
    super.key,
    required this.lesson,
    this.onTap,
    this.showProgress = false,
    this.isCompact = false,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(isCompact ? 12 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // 课程图标
                  Container(
                    width: isCompact ? 40 : 48,
                    height: isCompact ? 40 : 48,
                    decoration: BoxDecoration(
                      color: _getLessonTypeColor(lesson.type).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getLessonTypeIcon(lesson.type),
                      color: _getLessonTypeColor(lesson.type),
                      size: isCompact ? 20 : 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // 课程信息
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: isCompact ? 14 : 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (!isCompact) ...[
                          const SizedBox(height: 4),
                          Text(
                            lesson.description,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  // 状态指示器
                  _buildStatusIndicator(context),
                ],
              ),
              
              if (!isCompact) ...[
                const SizedBox(height: 12),
                
                // 课程标签
                Row(
                  children: [
                    _buildDifficultyChip(context),
                    const SizedBox(width: 8),
                    _buildDurationChip(context),
                    const Spacer(),
                    if (lesson.bestScore != null)
                      _buildScoreChip(context),
                  ],
                ),
              ],
              
              // 进度条
              if (showProgress && lesson.progress > 0) ...[
                const SizedBox(height: 12),
                _buildProgressBar(context),
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  /// 构建状态指示器
  Widget _buildStatusIndicator(BuildContext context) {
    final theme = Theme.of(context);
    
    switch (lesson.status) {
      case LessonStatus.completed:
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.green,
            size: 16,
          ),
        );
      case LessonStatus.inProgress:
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.play_arrow,
            color: Colors.orange,
            size: 16,
          ),
        );
      case LessonStatus.locked:
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            size: 16,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
  
  /// 构建难度标签
  Widget _buildDifficultyChip(BuildContext context) {
    final theme = Theme.of(context);
    final difficultyText = _getDifficultyText(lesson.difficulty);
    final difficultyColor = _getDifficultyColor(lesson.difficulty);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: difficultyColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        difficultyText,
        style: theme.textTheme.bodySmall?.copyWith(
          color: difficultyColor,
          fontWeight: FontWeight.w500,
          fontSize: 10,
        ),
      ),
    );
  }
  
  /// 构建时长标签
  Widget _buildDurationChip(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time,
            size: 10,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 2),
          Text(
            '${lesson.estimatedDuration}分钟',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
  
  /// 构建分数标签
  Widget _buildScoreChip(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            size: 10,
            color: Colors.amber,
          ),
          const SizedBox(width: 2),
          Text(
            '${lesson.bestScore}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.amber.shade700,
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
  
  /// 构建进度条
  Widget _buildProgressBar(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '进度',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            Text(
              '${lesson.progressPercentage}%',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: lesson.progress,
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
        ),
      ],
    );
  }
  
  /// 获取课程类型图标
  IconData _getLessonTypeIcon(LessonType type) {
    switch (type) {
      case LessonType.alphabet:
        return Icons.text_fields;
      case LessonType.numbers:
        return Icons.numbers;
      case LessonType.shapes:
        return Icons.category;
      case LessonType.colors:
        return Icons.palette;
      case LessonType.animals:
        return Icons.pets;
      case LessonType.vehicles:
        return Icons.directions_car;
      case LessonType.food:
        return Icons.restaurant;
      case LessonType.family:
        return Icons.family_restroom;
      case LessonType.bodyParts:
        return Icons.accessibility;
      case LessonType.dailyItems:
        return Icons.home;
      case LessonType.video:
        return Icons.play_circle;
      case LessonType.interactive:
        return Icons.touch_app;
      case LessonType.quiz:
        return Icons.quiz;
      case LessonType.reading:
        return Icons.menu_book;
      case LessonType.game:
        return Icons.games;
    }
  }
  
  /// 获取课程类型颜色
  Color _getLessonTypeColor(LessonType type) {
    switch (type) {
      case LessonType.alphabet:
        return Colors.blue;
      case LessonType.numbers:
        return Colors.green;
      case LessonType.shapes:
        return Colors.purple;
      case LessonType.colors:
        return Colors.red;
      case LessonType.animals:
        return Colors.brown;
      case LessonType.vehicles:
        return Colors.grey;
      case LessonType.food:
        return Colors.orange;
      case LessonType.family:
        return Colors.pink;
      case LessonType.bodyParts:
        return Colors.teal;
      case LessonType.dailyItems:
        return Colors.indigo;
      case LessonType.video:
        return Colors.red;
      case LessonType.interactive:
        return Colors.blue;
      case LessonType.quiz:
        return Colors.green;
      case LessonType.reading:
        return Colors.brown;
      case LessonType.game:
        return Colors.purple;
    }
  }
  
  /// 获取难度文本
  String _getDifficultyText(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return '初级';
      case DifficultyLevel.intermediate:
        return '中级';
      case DifficultyLevel.advanced:
        return '高级';
    }
  }
  
  /// 获取难度颜色
  Color _getDifficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return Colors.green;
      case DifficultyLevel.intermediate:
        return Colors.orange;
      case DifficultyLevel.advanced:
        return Colors.red;
    }
  }
}