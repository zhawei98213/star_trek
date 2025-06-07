import 'package:flutter/material.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../../../core/theme/app_theme.dart';

/// 课程信息卡片组件
/// 
/// 显示课程的详细信息，包括基本信息、学习目标、技能要求等
class LessonInfoCard extends StatelessWidget {
  final LessonEntity lesson;
  final bool showFullDescription; // 是否显示完整描述
  final VoidCallback? onDescriptionToggle; // 描述展开/收起回调
  
  const LessonInfoCard({
    super.key,
    required this.lesson,
    this.showFullDescription = false,
    this.onDescriptionToggle,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 基本信息卡片
        _buildBasicInfoCard(context),
        
        const SizedBox(height: 16),
        
        // 课程描述
        _buildDescriptionCard(context),
        
        const SizedBox(height: 16),
        
        // 学习目标
        _buildLearningObjectives(context),
        
        const SizedBox(height: 16),
        
        // 技能要求
        _buildSkillRequirements(context),
        
        const SizedBox(height: 16),
        
        // 课程标签
        _buildCourseTags(context),
      ],
    );
  }
  
  /// 构建基本信息卡片
  Widget _buildBasicInfoCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '课程信息',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 信息网格
            _buildInfoGrid(context),
          ],
        ),
      ),
    );
  }
  
  /// 构建信息网格
  Widget _buildInfoGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                context,
                icon: Icons.access_time,
                label: '预计时长',
                value: '${lesson.estimatedDuration}分钟',
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoItem(
                context,
                icon: Icons.signal_cellular_alt,
                label: '难度等级',
                value: _getDifficultyText(lesson.difficulty),
                color: _getDifficultyColor(lesson.difficulty),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                context,
                icon: Icons.people,
                label: '适合年龄',
                value: _getAgeGroupText(lesson.ageGroup),
                color: Colors.purple,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoItem(
                context,
                icon: Icons.category,
                label: '课程类型',
                value: _getLessonTypeText(lesson.type),
                color: _getLessonTypeColor(lesson.type),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                context,
                icon: Icons.list,
                label: '内容数量',
                value: '${lesson.contents.length}个',
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoItem(
                context,
                icon: Icons.star,
                label: '课程评分',
                value: '--',  // rating属性不存在，暂时显示--
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  /// 构建信息项
  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String label,
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
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  /// 构建描述卡片
  Widget _buildDescriptionCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '课程描述',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 12),
            
            Text(
              lesson.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.6,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
              ),
              maxLines: showFullDescription ? null : 3,
              overflow: showFullDescription ? null : TextOverflow.ellipsis,
            ),
            
            if (lesson.description.length > 100) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onDescriptionToggle,
                child: Text(
                  showFullDescription ? '收起' : '展开更多',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  /// 构建学习目标
  Widget _buildLearningObjectives(BuildContext context) {
    // 暂时返回空组件，因为LessonEntity中没有learningObjectives属性
    return const SizedBox.shrink();
  }
  

  
  /// 构建技能要求
  Widget _buildSkillRequirements(BuildContext context) {
    // 暂时返回空组件，因为LessonEntity中没有prerequisites属性
    return const SizedBox.shrink();
  }
  

  
  /// 构建课程标签
  Widget _buildCourseTags(BuildContext context) {
    final tags = _generateCourseTags();
    
    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_offer,
                  color: Colors.purple,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '课程标签',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: tag.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: tag.color.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        tag.icon,
                        size: 14,
                        color: tag.color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        tag.text,
                        style: TextStyle(
                          color: tag.color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
  
  // ==================== Helper Methods ====================
  
  /// 生成课程标签
  List<CourseTag> _generateCourseTags() {
    final tags = <CourseTag>[];
    
    // 根据课程状态添加标签
    if (lesson.status == LessonStatus.completed) {
      tags.add(CourseTag(
        icon: Icons.check_circle,
        text: '已完成',
        color: Colors.green,
      ));
    }
    
    // 根据难度添加标签
    if (lesson.difficulty == DifficultyLevel.beginner) {
      tags.add(CourseTag(
        icon: Icons.child_care,
        text: '适合新手',
        color: Colors.green,
      ));
    } else if (lesson.difficulty == DifficultyLevel.advanced) {
      tags.add(CourseTag(
        icon: Icons.star,
        text: '高级课程',
        color: Colors.red,
      ));
    }
    
    // 根据内容类型添加标签
    final hasVideo = lesson.contents.any((c) => c.type == ContentType.video);
    if (hasVideo) {
      tags.add(CourseTag(
        icon: Icons.play_circle,
        text: '视频课程',
        color: Colors.blue,
      ));
    }
    
    final hasInteractive = lesson.contents.any((c) => c.type == ContentType.interactive);
    if (hasInteractive) {
      tags.add(CourseTag(
        icon: Icons.touch_app,
        text: '互动学习',
        color: Colors.purple,
      ));
    }
    
    final hasQuiz = lesson.contents.any((c) => c.type == ContentType.quiz);
    if (hasQuiz) {
      tags.add(CourseTag(
        icon: Icons.quiz,
        text: '包含测验',
        color: Colors.orange,
      ));
    }
    
    // 根据时长添加标签
    if (lesson.estimatedDuration <= 10) {
      tags.add(CourseTag(
        icon: Icons.flash_on,
        text: '快速学习',
        color: Colors.amber,
      ));
    } else if (lesson.estimatedDuration >= 60) {
      tags.add(CourseTag(
        icon: Icons.schedule,
        text: '深度学习',
        color: Colors.indigo,
      ));
    }
    
    return tags;
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
  
  /// 获取年龄组文本
  String _getAgeGroupText(AgeGroup ageGroup) {
    switch (ageGroup) {
      case AgeGroup.preschool:
        return '学前(3-5岁)';
      case AgeGroup.elementary:
        return '小学(6-8岁)';
      case AgeGroup.middle:
        return '中学(9-12岁)';
    }
  }
  
  /// 获取课程类型文本
  String _getLessonTypeText(LessonType type) {
    switch (type) {
      case LessonType.alphabet:
        return '字母学习';
      case LessonType.numbers:
        return '数字学习';
      case LessonType.colors:
        return '颜色认知';
      case LessonType.shapes:
        return '形状认知';
      case LessonType.animals:
        return '动物认知';
      case LessonType.food:
        return '食物认知';
      case LessonType.vehicles:
        return '交通工具';
      case LessonType.family:
        return '家庭成员';
      case LessonType.bodyParts:
        return '身体部位';
      case LessonType.dailyItems:
        return '日常用品';
      case LessonType.video:
        return '视频课程';
      case LessonType.interactive:
        return '互动课程';
      case LessonType.quiz:
        return '测验课程';
      case LessonType.game:
        return '游戏课程';
      case LessonType.reading:
        return '阅读理解';
    }
  }
  
  /// 获取课程类型颜色
  Color _getLessonTypeColor(LessonType type) {
    switch (type) {
      case LessonType.alphabet:
        return Colors.blue;
      case LessonType.numbers:
        return Colors.green;
      case LessonType.colors:
        return Colors.purple;
      case LessonType.shapes:
        return Colors.orange;
      case LessonType.animals:
        return Colors.brown;
      case LessonType.food:
        return Colors.red;
      case LessonType.vehicles:
        return Colors.indigo;
      case LessonType.family:
        return Colors.pink;
      case LessonType.bodyParts:
        return Colors.teal;
      case LessonType.dailyItems:
        return Colors.cyan;
      case LessonType.video:
        return Colors.amber;
      case LessonType.interactive:
        return Colors.lime;
      case LessonType.quiz:
        return Colors.deepOrange;
      case LessonType.reading:
        return Colors.deepPurple;
      case LessonType.game:
        return Colors.indigo;
    }
  }
}

/// 课程标签数据类
class CourseTag {
  final IconData icon;
  final String text;
  final Color color;
  
  CourseTag({
    required this.icon,
    required this.text,
    required this.color,
  });
}