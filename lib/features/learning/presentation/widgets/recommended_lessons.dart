import 'package:flutter/material.dart';
import '../../domain/entities/lesson_entity.dart';

/// 推荐课程组件
/// 
/// 显示基于用户进度和偏好的推荐学习内容
class RecommendedLessons extends StatelessWidget {
  final List<LessonEntity> lessons;
  final Function(LessonEntity) onLessonTap;
  final VoidCallback? onSeeAllTap;
  
  const RecommendedLessons({
    super.key,
    required this.lessons,
    required this.onLessonTap,
    this.onSeeAllTap,
  });
  
  @override
  Widget build(BuildContext context) {
    if (lessons.isEmpty) {
      return _buildEmptyState(context);
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题栏
        _buildHeader(context),
        
        const SizedBox(height: 16),
        
        // 课程列表
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < lessons.length - 1 ? 16 : 0,
                ),
                child: _buildLessonCard(context, lessons[index]),
              );
            },
          ),
        ),
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
            Icons.recommend,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(
            '推荐课程',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          if (onSeeAllTap != null)
            TextButton(
              onPressed: onSeeAllTap,
              child: Text(
                '查看全部',
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
  
  /// 构建课程卡片
  Widget _buildLessonCard(BuildContext context, LessonEntity lesson) {
    return GestureDetector(
      onTap: () => onLessonTap(lesson),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 课程封面
            _buildLessonCover(context, lesson),
            
            // 课程信息
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 课程标题
                    Text(
                      lesson.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // 课程描述
                    Text(
                      lesson.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const Spacer(),
                    
                    // 课程标签和进度
                    _buildLessonFooter(context, lesson),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// 构建课程封面
  Widget _buildLessonCover(BuildContext context, LessonEntity lesson) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _getLessonGradientColors(lesson.type),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          // 背景图案
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              _getLessonTypeIcon(lesson.type),
              size: 80,
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          
          // 课程信息
          Positioned(
            left: 16,
            top: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 课程类型
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getLessonTypeText(lesson.type),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // 难度等级
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getDifficultyText(lesson.difficulty),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // 时长
          Positioned(
            right: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Colors.white,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${lesson.estimatedDuration}分钟',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  /// 构建课程底部信息
  Widget _buildLessonFooter(BuildContext context, LessonEntity lesson) {
    return Row(
      children: [
        // 进度指示器
        if (lesson.progress > 0)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '进度 ${(lesson.progress * 100).toInt()}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: lesson.progress,
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                  minHeight: 3,
                ),
              ],
            ),
          )
        else
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '开始学习',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        
        const SizedBox(width: 8),
        
        // 收藏按钮
        Icon(
          Icons.favorite_border,
          color: Colors.grey,
          size: 20,
        ),
      ],
    );
  }
  
  /// 构建空状态
  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(
            Icons.school_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无推荐课程',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '完成更多课程后，我们会为您推荐合适的内容',
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
  
  /// 获取课程类型渐变色
  List<Color> _getLessonGradientColors(LessonType type) {
    switch (type) {
      case LessonType.alphabet:
        return [Colors.red.shade400, Colors.red.shade600];
      case LessonType.numbers:
        return [Colors.blue.shade400, Colors.blue.shade600];
      case LessonType.shapes:
        return [Colors.green.shade400, Colors.green.shade600];
      case LessonType.colors:
        return [Colors.purple.shade400, Colors.purple.shade600];
      case LessonType.animals:
        return [Colors.orange.shade400, Colors.orange.shade600];
      case LessonType.vehicles:
        return [Colors.cyan.shade400, Colors.cyan.shade600];
      case LessonType.food:
        return [Colors.amber.shade400, Colors.amber.shade600];
      case LessonType.family:
        return [Colors.pink.shade400, Colors.pink.shade600];
      case LessonType.bodyParts:
        return [Colors.teal.shade400, Colors.teal.shade600];
      case LessonType.dailyItems:
        return [Colors.indigo.shade400, Colors.indigo.shade600];
      case LessonType.video:
        return [Colors.blue.shade400, Colors.blue.shade600];
      case LessonType.interactive:
        return [Colors.purple.shade400, Colors.purple.shade600];
      case LessonType.quiz:
        return [Colors.orange.shade400, Colors.orange.shade600];
      case LessonType.reading:
        return [Colors.green.shade400, Colors.green.shade600];
      case LessonType.game:
        return [Colors.pink.shade400, Colors.pink.shade600];
    }
  }
  
  /// 获取课程类型图标
  IconData _getLessonTypeIcon(LessonType type) {
    switch (type) {
      case LessonType.alphabet:
        return Icons.abc;
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
        return Icons.play_circle_filled;
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
  
  /// 获取课程类型文本
  String _getLessonTypeText(LessonType type) {
    switch (type) {
      case LessonType.alphabet:
        return '字母';
      case LessonType.numbers:
        return '数字';
      case LessonType.shapes:
        return '形状';
      case LessonType.colors:
        return '颜色';
      case LessonType.animals:
        return '动物';
      case LessonType.vehicles:
        return '交通工具';
      case LessonType.food:
        return '食物';
      case LessonType.family:
        return '家庭';
      case LessonType.bodyParts:
        return '身体部位';
      case LessonType.dailyItems:
        return '日常用品';
      case LessonType.video:
        return '视频';
      case LessonType.interactive:
        return '互动';
      case LessonType.quiz:
        return '测验';
      case LessonType.reading:
        return '阅读';
      case LessonType.game:
        return '游戏';
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
}