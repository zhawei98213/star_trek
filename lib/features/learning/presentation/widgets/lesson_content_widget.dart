import 'package:flutter/material.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../../../core/theme/app_theme.dart';

/// 课程内容组件
/// 
/// 显示课程的内容列表，包括各种类型的学习材料
class LessonContentWidget extends StatelessWidget {
  final List<LessonContentEntity> contents;
  final Function(LessonContentEntity)? onContentTap;
  final double? progress; // 当前学习进度
  
  const LessonContentWidget({
    super.key,
    required this.contents,
    this.onContentTap,
    this.progress,
  });
  
  @override
  Widget build(BuildContext context) {
    if (contents.isEmpty) {
      return _buildEmptyState(context);
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题
        Text(
          '课程内容',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // 内容列表
        ...contents.asMap().entries.map((entry) {
          final index = entry.key;
          final content = entry.value;
          final isCompleted = _isContentCompleted(index);
          final isUnlocked = _isContentUnlocked(index);
          
          return _buildContentItem(
            context,
            content: content,
            index: index + 1,
            isCompleted: isCompleted,
            isUnlocked: isUnlocked,
            onTap: isUnlocked ? () => onContentTap?.call(content) : null,
          );
        }),
        
        const SizedBox(height: 16),
        
        // 进度总结
        _buildProgressSummary(context),
      ],
    );
  }
  
  /// 构建空状态
  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.library_books_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            '暂无课程内容',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '课程内容正在准备中，请稍后再来查看',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  /// 构建内容项
  Widget _buildContentItem(
    BuildContext context, {
    required LessonContentEntity content,
    required int index,
    required bool isCompleted,
    required bool isUnlocked,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getContentBackgroundColor(context, isCompleted, isUnlocked),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _getContentBorderColor(context, isCompleted, isUnlocked),
                width: 1.5,
              ),
              boxShadow: isUnlocked ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ] : null,
            ),
            child: Row(
              children: [
                // 序号和状态指示器
                _buildContentIndicator(
                  context,
                  index: index,
                  isCompleted: isCompleted,
                  isUnlocked: isUnlocked,
                ),
                
                const SizedBox(width: 16),
                
                // 内容信息
                Expanded(
                  child: _buildContentInfo(context, content, isUnlocked),
                ),
                
                const SizedBox(width: 12),
                
                // 操作按钮
                _buildContentAction(
                  context,
                  content: content,
                  isCompleted: isCompleted,
                  isUnlocked: isUnlocked,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  /// 构建内容指示器
  Widget _buildContentIndicator(
    BuildContext context, {
    required int index,
    required bool isCompleted,
    required bool isUnlocked,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: _getIndicatorColor(context, isCompleted, isUnlocked),
        shape: BoxShape.circle,
        boxShadow: isUnlocked ? [
          BoxShadow(
            color: _getIndicatorColor(context, isCompleted, isUnlocked)
                .withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ] : null,
      ),
      child: Center(
        child: _buildIndicatorContent(index, isCompleted, isUnlocked),
      ),
    );
  }
  
  /// 构建指示器内容
  Widget _buildIndicatorContent(int index, bool isCompleted, bool isUnlocked) {
    if (isCompleted) {
      return const Icon(
        Icons.check,
        color: Colors.white,
        size: 20,
      );
    } else if (isUnlocked) {
      return Text(
        '$index',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return const Icon(
        Icons.lock,
        color: Colors.white,
        size: 18,
      );
    }
  }
  
  /// 构建内容信息
  Widget _buildContentInfo(
    BuildContext context,
    LessonContentEntity content,
    bool isUnlocked,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 内容标题
        Text(
          content.title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: isUnlocked
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        
        const SizedBox(height: 6),
        
        // 内容描述
        if (content.description != null && content.description!.isNotEmpty)
          Text(
            content.description!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isUnlocked
                  ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)
                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        
        const SizedBox(height: 8),
        
        // 内容元数据
        Row(
          children: [
            // 内容类型
            _buildMetadataChip(
              context,
              icon: _getContentTypeIcon(content.type),
              text: _getContentTypeText(content.type),
              color: _getContentTypeColor(content.type),
              isEnabled: isUnlocked,
            ),
            
            const SizedBox(width: 8),
            
            // 预估时长（暂时使用固定值，因为LessonContentEntity中没有estimatedDuration属性）
            _buildMetadataChip(
              context,
              icon: Icons.access_time,
              text: '5分钟',
              color: Colors.grey,
              isEnabled: isUnlocked,
            ),
          ],
        ),
      ],
    );
  }
  
  /// 构建元数据标签
  Widget _buildMetadataChip(
    BuildContext context, {
    required IconData icon,
    required String text,
    required Color color,
    required bool isEnabled,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isEnabled
            ? color.withValues(alpha: 0.1)
            : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: isEnabled ? color : Colors.grey,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: isEnabled ? color : Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  /// 构建内容操作
  Widget _buildContentAction(
    BuildContext context, {
    required LessonContentEntity content,
    required bool isCompleted,
    required bool isUnlocked,
  }) {
    if (!isUnlocked) {
      return Icon(
        Icons.lock,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
        size: 20,
      );
    }
    
    if (isCompleted) {
      return Container(
        padding: const EdgeInsets.all(8),
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
    }
    
    return Icon(
      _getContentActionIcon(content.type),
      color: AppColors.primary,
      size: 24,
    );
  }
  
  /// 构建进度总结
  Widget _buildProgressSummary(BuildContext context) {
    final completedCount = _getCompletedCount();
    final totalCount = contents.length;
    final progressPercentage = totalCount > 0 ? (completedCount / totalCount) : 0.0;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '学习进度',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Spacer(),
              Text(
                '$completedCount/$totalCount',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 进度条
          LinearProgressIndicator(
            value: progressPercentage,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
            minHeight: 8,
          ),
          
          const SizedBox(height: 8),
          
          Text(
            '已完成 ${(progressPercentage * 100).toInt()}% 的内容',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
  
  // ==================== Helper Methods ====================
  
  /// 判断内容是否已完成
  bool _isContentCompleted(int index) {
    if (progress == null) return false;
    return index < (progress! * contents.length);
  }
  
  /// 判断内容是否已解锁
  bool _isContentUnlocked(int index) {
    // 第一个内容总是解锁的
    if (index == 0) return true;
    
    // 如果前一个内容已完成，则当前内容解锁
    return _isContentCompleted(index - 1);
  }
  
  /// 获取已完成内容数量
  int _getCompletedCount() {
    if (progress == null) return 0;
    return (progress! * contents.length).floor();
  }
  
  /// 获取内容背景色
  Color _getContentBackgroundColor(
    BuildContext context,
    bool isCompleted,
    bool isUnlocked,
  ) {
    if (isCompleted) {
      return Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3);
    } else if (isUnlocked) {
      return Theme.of(context).colorScheme.surface;
    } else {
      return Theme.of(context).colorScheme.surfaceContainerHighest;
    }
  }
  
  /// 获取内容边框色
  Color _getContentBorderColor(
    BuildContext context,
    bool isCompleted,
    bool isUnlocked,
  ) {
    if (isCompleted) {
      return Theme.of(context).colorScheme.primary.withValues(alpha: 0.5);
    } else if (isUnlocked) {
      return Theme.of(context).colorScheme.outline.withValues(alpha: 0.3);
    } else {
      return Colors.transparent;
    }
  }
  
  /// 获取指示器颜色
  Color _getIndicatorColor(
    BuildContext context,
    bool isCompleted,
    bool isUnlocked,
  ) {
    if (isCompleted) {
      return Colors.green;
    } else if (isUnlocked) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return Colors.grey;
    }
  }
  
  /// 获取内容类型图标
  IconData _getContentTypeIcon(ContentType type) {
    switch (type) {
      case ContentType.text:
        return Icons.article;
      case ContentType.image:
        return Icons.image;
      case ContentType.audio:
        return Icons.headphones;
      case ContentType.video:
        return Icons.play_circle_outline;
      case ContentType.interactive:
        return Icons.touch_app;
      case ContentType.quiz:
        return Icons.quiz;
      case ContentType.game:
        return Icons.games;
    }
  }
  
  /// 获取内容类型文本
  String _getContentTypeText(ContentType type) {
    switch (type) {
      case ContentType.text:
        return '文本';
      case ContentType.image:
        return '图片';
      case ContentType.audio:
        return '音频';
      case ContentType.video:
        return '视频';
      case ContentType.interactive:
        return '互动';
      case ContentType.quiz:
        return '测验';
      case ContentType.game:
        return '游戏';
    }
  }
  
  /// 获取内容类型颜色
  Color _getContentTypeColor(ContentType type) {
    switch (type) {
      case ContentType.text:
        return Colors.blue;
      case ContentType.image:
        return Colors.purple;
      case ContentType.audio:
        return Colors.orange;
      case ContentType.video:
        return Colors.red;
      case ContentType.interactive:
        return Colors.green;
      case ContentType.quiz:
        return Colors.amber;
      case ContentType.game:
        return Colors.pink;
    }
  }
  
  /// 获取内容操作图标
  IconData _getContentActionIcon(ContentType type) {
    switch (type) {
      case ContentType.text:
        return Icons.menu_book;
      case ContentType.image:
        return Icons.visibility;
      case ContentType.audio:
        return Icons.play_arrow;
      case ContentType.video:
        return Icons.play_arrow;
      case ContentType.interactive:
        return Icons.touch_app;
      case ContentType.quiz:
        return Icons.quiz;
      case ContentType.game:
        return Icons.play_arrow;
    }
  }
}