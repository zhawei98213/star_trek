import 'package:flutter/material.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../../../core/theme/app_theme.dart';

/// 课程操作组件
/// 
/// 提供课程相关的操作按钮，如开始学习、继续学习、重新学习等
class LessonActions extends StatelessWidget {
  final LessonEntity lesson;
  final VoidCallback? onStart; // 开始学习回调
  final VoidCallback? onContinue; // 继续学习回调
  final VoidCallback? onRestart; // 重新学习回调
  final VoidCallback? onBookmark; // 收藏回调
  final VoidCallback? onShare; // 分享回调
  final VoidCallback? onDownload; // 下载回调
  final bool showSecondaryActions; // 是否显示次要操作
  
  const LessonActions({
    super.key,
    required this.lesson,
    this.onStart,
    this.onContinue,
    this.onRestart,
    this.onBookmark,
    this.onShare,
    this.onDownload,
    this.showSecondaryActions = true,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 主要操作按钮
        _buildPrimaryAction(context),
        
        if (showSecondaryActions) ...[
          const SizedBox(height: 16),
          
          // 次要操作按钮
          _buildSecondaryActions(context),
        ],
      ],
    );
  }
  
  /// 构建主要操作按钮
  Widget _buildPrimaryAction(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: _getPrimaryButtonGradient(),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _getPrimaryButtonColor().withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _getPrimaryAction(),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getPrimaryActionIcon(),
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  _getPrimaryActionText(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (lesson.status == LessonStatus.inProgress) ...[
                  const SizedBox(width: 8),
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
                      '${(lesson.progress * 100).toInt()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  /// 构建次要操作按钮
  Widget _buildSecondaryActions(BuildContext context) {
    return Row(
      children: [
        // 重新学习按钮（仅在已完成或进行中时显示）
        if (lesson.status == LessonStatus.completed ||
            lesson.status == LessonStatus.inProgress)
          Expanded(
            child: _buildSecondaryButton(
              context,
              icon: Icons.refresh,
              text: '重新学习',
              onTap: onRestart,
              color: Colors.orange,
            ),
          ),
        
        if (lesson.status == LessonStatus.completed ||
            lesson.status == LessonStatus.inProgress)
          const SizedBox(width: 12),
        
        // 收藏按钮
        Expanded(
          child: _buildSecondaryButton(
            context,
            icon: lesson.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            text: lesson.isBookmarked ? '已收藏' : '收藏',
            onTap: onBookmark,
            color: lesson.isBookmarked ? AppColors.primary : Colors.grey,
          ),
        ),
        
        const SizedBox(width: 12),
        
        // 分享按钮
        Expanded(
          child: _buildSecondaryButton(
            context,
            icon: Icons.share,
            text: '分享',
            onTap: onShare,
            color: Colors.blue,
          ),
        ),
        
        const SizedBox(width: 12),
        
        // 下载按钮
        Expanded(
          child: _buildSecondaryButton(
            context,
            icon: lesson.isDownloaded ? Icons.download_done : Icons.download,
            text: lesson.isDownloaded ? '已下载' : '下载',
            onTap: onDownload,
            color: lesson.isDownloaded ? Colors.green : Colors.purple,
          ),
        ),
      ],
    );
  }
  
  /// 构建次要按钮
  Widget _buildSecondaryButton(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback? onTap,
    required Color color,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                text,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // ==================== Helper Methods ====================
  
  /// 获取主要操作
  VoidCallback? _getPrimaryAction() {
    switch (lesson.status) {
      case LessonStatus.notStarted:
        return onStart;
      case LessonStatus.inProgress:
        return onContinue;
      case LessonStatus.completed:
        return onRestart;
      case LessonStatus.locked:
        return null; // 锁定状态不可操作
    }
  }
  
  /// 获取主要操作图标
  IconData _getPrimaryActionIcon() {
    switch (lesson.status) {
      case LessonStatus.notStarted:
        return Icons.play_arrow;
      case LessonStatus.inProgress:
        return Icons.play_arrow;
      case LessonStatus.completed:
        return Icons.refresh;
      case LessonStatus.locked:
        return Icons.lock;
    }
  }
  
  /// 获取主要操作文本
  String _getPrimaryActionText() {
    switch (lesson.status) {
      case LessonStatus.notStarted:
        return '开始学习';
      case LessonStatus.inProgress:
        return '继续学习';
      case LessonStatus.completed:
        return '重新学习';
      case LessonStatus.locked:
        return '课程已锁定';
    }
  }
  
  /// 获取主要按钮颜色
  Color _getPrimaryButtonColor() {
    switch (lesson.status) {
      case LessonStatus.notStarted:
        return AppColors.primary;
      case LessonStatus.inProgress:
        return Colors.orange;
      case LessonStatus.completed:
        return Colors.green;
      case LessonStatus.locked:
        return Colors.grey;
    }
  }
  
  /// 获取主要按钮渐变
  LinearGradient _getPrimaryButtonGradient() {
    final color = _getPrimaryButtonColor();
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color,
        color.withValues(alpha: 0.8),
      ],
    );
  }
}

/// 扩展LessonEntity以支持收藏和下载状态
extension LessonEntityActionsExtension on LessonEntity {
  /// 是否已收藏
  bool get isBookmarked {
    // 这里可以从本地存储或状态管理中获取收藏状态
    // 目前返回false作为默认值
    return false;
  }
  
  /// 是否已下载
  bool get isDownloaded {
    // 这里可以从本地存储中获取下载状态
    // 目前返回false作为默认值
    return false;
  }
}