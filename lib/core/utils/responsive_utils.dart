import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// 响应式布局工具类
/// 提供屏幕尺寸判断和适配方法
class ResponsiveUtils {
  /// 判断是否为平板设备
  static bool isTablet(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 768;
  }
  
  /// 判断是否为大屏设备（iPad Pro等）
  static bool isLargeTablet(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 1024;
  }
  
  /// 判断是否为横屏模式
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }
  
  /// 获取适配的水平内边距
  static double getHorizontalPadding(BuildContext context) {
    if (isTablet(context) && isLandscape(context)) {
      return AppTheme.tabletHorizontalPadding;
    }
    return AppTheme.spacingMedium;
  }
  
  /// 获取适配的垂直内边距
  static double getVerticalPadding(BuildContext context) {
    if (isTablet(context) && isLandscape(context)) {
      return AppTheme.tabletVerticalPadding;
    }
    return AppTheme.spacingMedium;
  }
  
  /// 获取内容区域最大宽度
  static double getContentMaxWidth(BuildContext context) {
    if (isTablet(context) && isLandscape(context)) {
      return AppTheme.tabletContentMaxWidth;
    }
    return double.infinity;
  }
  
  /// 获取网格列数
  static int getGridColumns(BuildContext context) {
    if (isLargeTablet(context) && isLandscape(context)) {
      return 4; // iPad Pro 横屏显示4列
    } else if (isTablet(context) && isLandscape(context)) {
      return 3; // 普通iPad横屏显示3列
    } else if (isTablet(context)) {
      return 2; // 平板竖屏显示2列
    }
    return 2; // 手机默认2列
  }
  
  /// 获取卡片宽高比
  static double getCardAspectRatio(BuildContext context) {
    if (isTablet(context) && isLandscape(context)) {
      return 1.2; // 横屏时卡片更宽
    }
    return 1.5; // 默认宽高比
  }
  
  /// 获取字体缩放因子
  static double getFontScale(BuildContext context) {
    if (isLargeTablet(context)) {
      return 1.1; // 大屏设备字体稍大
    }
    return 1.0;
  }
  
  /// 构建响应式容器
  static Widget buildResponsiveContainer({
    required BuildContext context,
    required Widget child,
    bool centerContent = true,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: getHorizontalPadding(context),
        vertical: getVerticalPadding(context),
      ),
      child: centerContent
          ? Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: getContentMaxWidth(context),
                ),
                child: child,
              ),
            )
          : child,
    );
  }
  
  /// 构建响应式行布局
  static Widget buildResponsiveRow({
    required BuildContext context,
    required List<Widget> children,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    if (isTablet(context) && isLandscape(context)) {
      // 横屏时使用行布局
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      );
    } else {
      // 竖屏或小屏时使用列布局
      return Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      );
    }
  }
  
  /// 获取侧边栏宽度
  static double getSidebarWidth(BuildContext context) {
    if (isLargeTablet(context) && isLandscape(context)) {
      return 300.0;
    } else if (isTablet(context) && isLandscape(context)) {
      return 250.0;
    }
    return 0.0; // 小屏不显示侧边栏
  }
  
  /// 判断是否应该显示侧边栏
  static bool shouldShowSidebar(BuildContext context) {
    return isTablet(context) && isLandscape(context);
  }
}