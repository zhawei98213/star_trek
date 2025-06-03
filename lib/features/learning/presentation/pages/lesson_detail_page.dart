import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/learning_bloc.dart';
import '../../domain/entities/lesson_entity.dart';

/// 课程详情页面
/// 
/// 显示课程的详细信息、学习内容和进度
class LessonDetailPage extends StatefulWidget {
  final String lessonId;
  
  const LessonDetailPage({
    super.key,
    required this.lessonId,
  });
  
  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  LessonEntity? lesson;
  
  @override
  void initState() {
    super.initState();
    _loadLessonDetails();
  }
  
  void _loadLessonDetails() {
    // 从 Bloc 状态中获取课程详情
    final state = context.read<LearningBloc>().state;
    if (state is LearningLoaded) {
      lesson = state.lessons.firstWhere(
        (l) => l.id == widget.lessonId,
        orElse: () => throw Exception('Lesson not found'),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (lesson == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('课程详情'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 课程封面和基本信息
          _buildSliverAppBar(context),
          
          // 课程内容
          SliverToBoxAdapter(
            child: Column(
              children: [
                // 课程信息卡片
                _buildLessonInfoCard(context),
                
                const SizedBox(height: 16),
                
                // 学习进度
                _buildProgressCard(context),
                
                const SizedBox(height: 16),
                
                // 课程内容列表
                _buildContentList(context),
                
                const SizedBox(height: 16),
                
                // 相关推荐
                _buildRelatedLessons(context),
                
                const SizedBox(height: 100), // 底部间距
              ],
            ),
          ),
        ],
      ),
      
      // 底部操作栏
      bottomNavigationBar: _buildBottomActionBar(context),
    );
  }
  
  /// 构建可折叠的应用栏
  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _getLessonGradientColors(lesson!.type),
            ),
          ),
          child: Stack(
            children: [
              // 背景图案
              Positioned(
                right: -50,
                top: -50,
                child: Icon(
                  _getLessonTypeIcon(lesson!.type),
                  size: 200,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
              
              // 课程基本信息
              Positioned(
                left: 20,
                right: 20,
                bottom: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 课程类型标签
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _getLessonTypeText(lesson!.type),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // 课程标题
                    Text(
                      lesson!.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // 课程基本信息
                    Row(
                      children: [
                        _buildInfoChip(
                          icon: Icons.access_time,
                          text: '${lesson!.estimatedDuration}分钟',
                        ),
                        const SizedBox(width: 12),
                        _buildInfoChip(
                          icon: Icons.star,
                          text: _getDifficultyText(lesson!.difficulty),
                        ),
                        const SizedBox(width: 12),
                        _buildInfoChip(
                          icon: Icons.people,
                          text: _getAgeGroupText(lesson!.ageGroup),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        // 收藏按钮
        IconButton(
          onPressed: _toggleFavorite,
          icon: Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
        ),
        
        // 分享按钮
        IconButton(
          onPressed: _shareLessson,
          icon: const Icon(Icons.share, color: Colors.white),
        ),
      ],
    );
  }
  
  /// 构建信息标签
  Widget _buildInfoChip({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
  
  /// 构建课程信息卡片
  Widget _buildLessonInfoCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
            '课程介绍',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 12),
          
          Text(
            lesson!.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 课程描述
          if (lesson!.description.isNotEmpty) ...[
            Text(
              '课程描述',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              lesson!.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
  
  /// 构建进度卡片
  Widget _buildProgressCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
                '学习进度',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '${(lesson!.progress * 100).toInt()}%',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          LinearProgressIndicator(
            value: lesson!.progress,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
            minHeight: 8,
          ),
          
          const SizedBox(height: 12),
          
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: lesson!.status == LessonStatus.completed
                    ? Colors.green
                    : Theme.of(context).colorScheme.onSurface,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                _getStatusText(lesson!.status),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: lesson!.status == LessonStatus.completed
                      ? Colors.green
                      : Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  /// 构建内容列表
  Widget _buildContentList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
            '课程内容',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 16),
          
          ...lesson!.contents.asMap().entries.map((entry) {
            final index = entry.key;
            final content = entry.value;
            final isCompleted = index < (lesson!.progress * lesson!.contents.length);
            
            return _buildContentItem(
              context,
              content: content,
              index: index + 1,
              isCompleted: isCompleted,
              onTap: () => _startContent(content),
            );
          }),
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
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isCompleted
              ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCompleted
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            // 序号和状态
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCompleted
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      )
                    : Text(
                        '$index',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // 内容信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Row(
                    children: [
                      Icon(
                        _getContentTypeIcon(content.type),
                        size: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getContentTypeText(content.type),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getContentTypeText(content.type),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // 播放按钮
            Icon(
              Icons.play_arrow,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
  
  /// 构建相关推荐
  Widget _buildRelatedLessons(BuildContext context) {
    // 这里应该从 API 获取相关课程
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '相关推荐',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 16),
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '完成此课程后，我们会为您推荐更多相关内容',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  /// 构建底部操作栏
  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 进度信息
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '进度: ${(lesson!.progress * 100).toInt()}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: lesson!.progress,
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                  minHeight: 4,
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 20),
          
          // 开始/继续学习按钮
          ElevatedButton(
            onPressed: _startLearning,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              lesson!.progress > 0 ? '继续学习' : '开始学习',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // ==================== Event Handlers ====================
  
  /// 切换收藏状态
  void _toggleFavorite() {
    // TODO: 实现收藏功能
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('已添加到收藏'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
  
  /// 分享课程
  void _shareLessson() {
    // TODO: 实现分享功能
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('分享功能开发中...'),
        duration: Duration(seconds: 2),
      ),
    );
  }
  
  /// 开始学习
  void _startLearning() {
    // TODO: 导航到学习界面
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('开始学习功能开发中...'),
        duration: Duration(seconds: 2),
      ),
    );
  }
  
  /// 开始特定内容
  void _startContent(LessonContentEntity content) {
    // TODO: 导航到具体内容学习界面
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('开始学习: ${content.title}'),
        duration: const Duration(seconds: 2),
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
        return [Colors.indigo.shade400, Colors.indigo.shade600];
      case LessonType.shapes:
        return [Colors.teal.shade400, Colors.teal.shade600];
      case LessonType.colors:
        return [Colors.amber.shade400, Colors.amber.shade600];
      case LessonType.animals:
        return [Colors.brown.shade400, Colors.brown.shade600];
      case LessonType.vehicles:
        return [Colors.grey.shade400, Colors.grey.shade600];
      case LessonType.food:
        return [Colors.lime.shade400, Colors.lime.shade600];
      case LessonType.family:
        return [Colors.cyan.shade400, Colors.cyan.shade600];
      case LessonType.bodyParts:
        return [Colors.deepOrange.shade400, Colors.deepOrange.shade600];
      case LessonType.dailyItems:
        return [Colors.lightBlue.shade400, Colors.lightBlue.shade600];
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
        return '互动课程';
      case LessonType.quiz:
        return '测验课程';
      case LessonType.reading:
        return '阅读课程';
      case LessonType.game:
        return '游戏课程';
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
  
  /// 获取年龄组文本
  String _getAgeGroupText(AgeGroup ageGroup) {
    switch (ageGroup) {
      case AgeGroup.preschool:
        return '学前班';
      case AgeGroup.elementary:
        return '小学';
      case AgeGroup.middle:
        return '中学';
    }
  }

  String _getContentTypeText(ContentType contentType) {
    switch (contentType) {
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
  
  /// 获取内容类型图标
  IconData _getContentTypeIcon(ContentType type) {
    switch (type) {
      case ContentType.video:
        return Icons.play_circle_outline;
      case ContentType.text:
        return Icons.article;
      case ContentType.image:
        return Icons.image;
      case ContentType.audio:
        return Icons.headphones;
      case ContentType.interactive:
        return Icons.touch_app;
      case ContentType.quiz:
        return Icons.quiz;
      case ContentType.game:
        return Icons.games;
    }
  }
}