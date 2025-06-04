import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';

/// 引导页面
/// 为首次使用的用户介绍应用功能和使用方法
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  // 引导页内容
  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      icon: Icons.rocket_launch,
      title: '欢迎来到Start Trek',
      description: '一个专为儿童设计的英语学习应用\n让学习变得有趣又有效',
      color: AppTheme.primaryColor,
    ),
    OnboardingItem(
      icon: Icons.games,
      title: '游戏化学习',
      description: '通过有趣的游戏和互动\n让孩子爱上英语学习',
      color: AppTheme.secondaryColor,
    ),
    OnboardingItem(
      icon: Icons.emoji_events,
      title: '成就系统',
      description: '完成学习任务获得积分和成就\n激发孩子的学习动力',
      color: AppTheme.successColor,
    ),
    OnboardingItem(
      icon: Icons.headphones,
      title: '音频学习',
      description: '标准发音和语音识别\n提升听说能力',
      color: AppTheme.warningColor,
    ),
    OnboardingItem(
      icon: Icons.family_restroom,
      title: '家长监控',
      description: '实时了解孩子的学习进度\n共同见证成长',
      color: AppTheme.primaryDarkColor,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// 下一页
  void _nextPage() {
    if (_currentPage < _onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: AppConstants.defaultAnimationDuration,
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  /// 跳过引导
  void _skipOnboarding() {
    _completeOnboarding();
  }

  /// 完成引导
  Future<void> _completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.keyFirstLaunch, false);
      
      if (mounted) {
        context.go(AppRouter.home);
      }
    } catch (e) {
      // 处理错误
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('保存设置失败：$e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 顶部跳过按钮
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 页面指示器
                  Row(
                    children: List.generate(
                      _onboardingItems.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(
                          right: AppTheme.spacingXSmall,
                        ),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == _currentPage
                              ? AppTheme.primaryColor
                              : AppTheme.borderColor,
                        ),
                      ),
                    ),
                  ),
                  
                  // 跳过按钮
                  TextButton(
                    onPressed: _skipOnboarding,
                    child: const Text(
                      '跳过',
                      style: TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: AppTheme.fontSizeMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // 引导内容
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingItems.length,
                itemBuilder: (context, index) {
                  final item = _onboardingItems[index];
                  return Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingLarge),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 图标
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: item.color.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item.icon,
                            size: 64,
                            color: item.color,
                          ),
                        ),
                        
                        const SizedBox(height: AppTheme.spacingXLarge),
                        
                        // 标题
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppTheme.textPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: AppTheme.spacingMedium),
                        
                        // 描述
                        Text(
                          item.description,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textSecondaryColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // 底部按钮
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLarge),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _onboardingItems[_currentPage].color,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppTheme.spacingMedium,
                    ),
                  ),
                  child: Text(
                    _currentPage == _onboardingItems.length - 1
                        ? '开始学习'
                        : '下一步',
                    style: const TextStyle(
                      fontSize: AppTheme.fontSizeLarge,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 引导页项目数据模型
class OnboardingItem {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const OnboardingItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}