import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/learning_bloc.dart';
import '../bloc/learning_event.dart';
import '../bloc/learning_state.dart';
import '../widgets/lesson_card.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';

/// 课程搜索页面
/// 
/// 提供课程搜索、筛选、排序等功能
class LessonSearchPage extends StatefulWidget {
  const LessonSearchPage({super.key});
  
  @override
  State<LessonSearchPage> createState() => _LessonSearchPageState();
}

class _LessonSearchPageState extends State<LessonSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  
  // 搜索和筛选状态
  String _searchQuery = '';
  String _selectedCategory = 'all';
  String _selectedDifficulty = 'all';
  String _selectedType = 'all';
  String _sortBy = 'relevance';
  bool _showFilters = false;
  
  // 搜索建议
  List<String> _searchSuggestions = [];
  bool _showSuggestions = false;
  
  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onSearchFocusChanged);
    
    // 初始加载所有课程
    context.read<LearningBloc>().add(
      LearningEvent.searchLessons(query: ''),
    );
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '搜索课程',
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(
              _showFilters ? Icons.filter_list : Icons.filter_list_outlined,
              color: _showFilters ? AppColors.primary : null,
            ),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 搜索栏
          _buildSearchBar(context),
          
          // 筛选器
          if (_showFilters) _buildFilters(context),
          
          // 搜索建议
          if (_showSuggestions) _buildSearchSuggestions(context),
          
          // 搜索结果
          Expanded(
            child: _buildSearchResults(context),
          ),
        ],
      ),
    );
  }
  
  /// 构建搜索栏
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _searchFocusNode.hasFocus
                      ? AppColors.primary
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: '搜索课程、主题或技能...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _clearSearch,
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onChanged: _onSearchChanged,
                onSubmitted: _onSearchSubmitted,
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // 语音搜索按钮
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.mic,
                color: Colors.white,
              ),
              onPressed: _startVoiceSearch,
            ),
          ),
        ],
      ),
    );
  }
  
  /// 构建筛选器
  Widget _buildFilters(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 筛选器标题
          Row(
            children: [
              Text(
                '筛选条件',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _resetFilters,
                child: const Text('重置'),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 筛选器选项
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // 分类筛选
                _buildFilterChip(
                  context,
                  label: '分类',
                  value: _selectedCategory,
                  options: {
                    'all': '全部',
                    'alphabet': '字母',
                    'numbers': '数字',
                    'colors': '颜色',
                    'shapes': '形状',
                    'animals': '动物',
                    'fruits': '水果',
                  },
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                    _performSearch();
                  },
                ),
                
                const SizedBox(width: 12),
                
                // 难度筛选
                _buildFilterChip(
                  context,
                  label: '难度',
                  value: _selectedDifficulty,
                  options: {
                    'all': '全部',
                    'beginner': '初级',
                    'intermediate': '中级',
                    'advanced': '高级',
                  },
                  onChanged: (value) {
                    setState(() {
                      _selectedDifficulty = value;
                    });
                    _performSearch();
                  },
                ),
                
                const SizedBox(width: 12),
                
                // 类型筛选
                _buildFilterChip(
                  context,
                  label: '类型',
                  value: _selectedType,
                  options: {
                    'all': '全部',
                    'video': '视频',
                    'interactive': '互动',
                    'game': '游戏',
                    'quiz': '测验',
                  },
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value;
                    });
                    _performSearch();
                  },
                ),
                
                const SizedBox(width: 12),
                
                // 排序筛选
                _buildFilterChip(
                  context,
                  label: '排序',
                  value: _sortBy,
                  options: {
                    'relevance': '相关性',
                    'difficulty': '难度',
                    'duration': '时长',
                    'rating': '评分',
                    'newest': '最新',
                  },
                  onChanged: (value) {
                    setState(() {
                      _sortBy = value;
                    });
                    _performSearch();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  /// 构建筛选器芯片
  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required String value,
    required Map<String, String> options,
    required ValueChanged<String> onChanged,
  }) {
    return PopupMenuButton<String>(
      initialValue: value,
      onSelected: onChanged,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: value != 'all' && value != 'relevance'
              ? AppColors.primary.withValues(alpha: 0.1)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: value != 'all' && value != 'relevance'
                ? AppColors.primary
                : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$label: ${options[value] ?? value}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: value != 'all' && value != 'relevance'
                    ? AppColors.primary
                    : null,
                fontWeight: value != 'all' && value != 'relevance'
                    ? FontWeight.w600
                    : null,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              size: 16,
              color: value != 'all' && value != 'relevance'
                  ? AppColors.primary
                  : null,
            ),
          ],
        ),
      ),
      itemBuilder: (context) {
        return options.entries.map((entry) {
          return PopupMenuItem<String>(
            value: entry.key,
            child: Text(entry.value),
          );
        }).toList();
      },
    );
  }
  
  /// 构建搜索建议
  Widget _buildSearchSuggestions(BuildContext context) {
    if (_searchSuggestions.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _searchSuggestions.length,
        itemBuilder: (context, index) {
          final suggestion = _searchSuggestions[index];
          return ListTile(
            leading: const Icon(
              Icons.search,
              size: 20,
            ),
            title: Text(
              suggestion,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.north_west,
                size: 16,
              ),
              onPressed: () {
                _searchController.text = suggestion;
                _onSearchSubmitted(suggestion);
              },
            ),
            onTap: () {
              _searchController.text = suggestion;
              _onSearchSubmitted(suggestion);
            },
          );
        },
      ),
    );
  }
  
  /// 构建搜索结果
  Widget _buildSearchResults(BuildContext context) {
    return BlocBuilder<LearningBloc, LearningState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: (message) => const LoadingWidget(),
          error: (failure) => CustomErrorWidget(
            message: failure.message,
            onRetry: () {
              _performSearch();
            },
          ),
          searchSuccess: (searchResults, searchQuery) => 
            _buildSearchResultsList(context, searchResults),
          loaded: (progress, lessons, searchResults, isSearching, searchQuery, completionResult) {
            if (isSearching && searchResults.isNotEmpty) {
              return _buildSearchResultsList(context, searchResults);
            }
            return _buildSearchResultsList(context, lessons);
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
  
  /// 构建搜索结果列表
  Widget _buildSearchResultsList(BuildContext context, List<LessonEntity> lessons) {
    if (lessons.isEmpty) {
      return _buildEmptyState(context);
    }
    
    return Column(
      children: [
        // 结果统计
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                '找到 ${lessons.length} 个课程',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const Spacer(),
              if (_searchQuery.isNotEmpty)
                TextButton.icon(
                  onPressed: _saveSearch,
                  icon: const Icon(
                    Icons.bookmark_add_outlined,
                    size: 16,
                  ),
                  label: const Text('保存搜索'),
                ),
            ],
          ),
        ),
        
        // 课程列表
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: LessonCard(
                  lesson: lesson,
                  onTap: () => _navigateToLessonDetail(lesson),
                  showProgress: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  /// 构建空状态
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isEmpty ? '开始搜索课程' : '未找到相关课程',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isEmpty
                  ? '输入关键词搜索您感兴趣的课程'
                  : '尝试使用其他关键词或调整筛选条件',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (_searchQuery.isNotEmpty)
              ElevatedButton(
                onPressed: _clearSearch,
                child: const Text('清除搜索'),
              ),
          ],
        ),
      ),
    );
  }
  
  // ==================== Event Handlers ====================
  
  /// 搜索焦点变化
  void _onSearchFocusChanged() {
    if (_searchFocusNode.hasFocus && _searchQuery.isNotEmpty) {
      _generateSearchSuggestions(_searchQuery);
    } else {
      setState(() {
        _showSuggestions = false;
      });
    }
  }
  
  /// 搜索内容变化
  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    
    if (query.isNotEmpty) {
      _generateSearchSuggestions(query);
    } else {
      setState(() {
        _showSuggestions = false;
      });
    }
  }
  
  /// 搜索提交
  void _onSearchSubmitted(String query) {
    setState(() {
      _searchQuery = query;
      _showSuggestions = false;
    });
    _searchFocusNode.unfocus();
    _performSearch();
  }
  
  /// 清除搜索
  void _clearSearch() {
    setState(() {
      _searchQuery = '';
      _showSuggestions = false;
    });
    _searchController.clear();
    _performSearch();
  }
  
  /// 重置筛选器
  void _resetFilters() {
    setState(() {
      _selectedCategory = 'all';
      _selectedDifficulty = 'all';
      _selectedType = 'all';
      _sortBy = 'relevance';
    });
    _performSearch();
  }
  
  /// 开始语音搜索
  void _startVoiceSearch() {
    // TODO: 实现语音搜索功能
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('语音搜索功能即将推出'),
      ),
    );
  }
  
  /// 保存搜索
  void _saveSearch() {
    // TODO: 实现保存搜索功能
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('搜索已保存'),
      ),
    );
  }
  
  /// 导航到课程详情
  void _navigateToLessonDetail(LessonEntity lesson) {
    Navigator.pushNamed(
      context,
      '/lesson-detail',
      arguments: lesson,
    );
  }
  
  // ==================== Helper Methods ====================
  
  /// 执行搜索
  void _performSearch() {
    final filters = _buildCurrentFilters();
    context.read<LearningBloc>().add(
      LearningEvent.searchLessons(
        query: _searchQuery,
        ageGroup: _parseAgeGroup(filters['category']),
        difficulty: _parseDifficultyLevel(filters['difficulty']),
        type: _parseLessonType(filters['type']),
      ),
    );
  }
  
  /// 构建当前筛选条件
  Map<String, dynamic> _buildCurrentFilters() {
    return {
      'category': _selectedCategory != 'all' ? _selectedCategory : null,
      'difficulty': _selectedDifficulty != 'all' ? _selectedDifficulty : null,
      'type': _selectedType != 'all' ? _selectedType : null,
      'sortBy': _sortBy,
    };
  }
  
  /// 生成搜索建议
  void _generateSearchSuggestions(String query) {
    // 模拟搜索建议生成
    final suggestions = <String>[];
    
    // 基于查询生成建议
    if (query.isNotEmpty) {
      final commonSuggestions = [
        '字母学习',
        '数字认知',
        '颜色识别',
        '形状认知',
        '动物世界',
        '水果认知',
        '基础英语',
        '数学启蒙',
        '科学探索',
        '艺术创作',
      ];
      
      // 筛选匹配的建议
      for (final suggestion in commonSuggestions) {
        if (suggestion.toLowerCase().contains(query.toLowerCase()) ||
            query.toLowerCase().contains(suggestion.toLowerCase())) {
          suggestions.add(suggestion);
        }
      }
      
      // 添加查询本身作为建议
      if (!suggestions.contains(query)) {
        suggestions.insert(0, query);
      }
    }
    
    setState(() {
      _searchSuggestions = suggestions.take(5).toList();
      _showSuggestions = suggestions.isNotEmpty;
    });
  }
  
  /// 解析年龄组
  AgeGroup? _parseAgeGroup(String? category) {
    if (category == null) return null;
    switch (category) {
      case 'preschool':
        return AgeGroup.preschool;
      case 'elementary':
        return AgeGroup.elementary;
      case 'middle':
        return AgeGroup.middle;
      default:
        return null;
    }
  }

  /// 解析难度等级
  DifficultyLevel? _parseDifficultyLevel(String? difficulty) {
    if (difficulty == null) return null;
    switch (difficulty) {
      case 'beginner':
        return DifficultyLevel.beginner;
      case 'intermediate':
        return DifficultyLevel.intermediate;
      case 'advanced':
        return DifficultyLevel.advanced;
      default:
        return null;
    }
  }

  /// 解析课程类型
  LessonType? _parseLessonType(String? type) {
    if (type == null) return null;
    switch (type) {
      case 'interactive':
        return LessonType.interactive;
      case 'video':
        return LessonType.video;
      case 'reading':
        return LessonType.reading;
      case 'quiz':
        return LessonType.quiz;
      case 'game':
        return LessonType.game;
      default:
        return null;
    }
  }
}