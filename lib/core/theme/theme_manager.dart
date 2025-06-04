import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/app_config.dart';
import '../utils/cache_manager.dart';

/// 主题模式
enum AppThemeMode {
  system,
  light,
  dark,
}

/// 颜色方案
enum AppColorScheme {
  starfleet, // 星际舰队蓝
  enterprise, // 企业号金
  klingon, // 克林贡红
  vulcan, // 瓦肯绿
  romulan, // 罗慕兰紫
}

/// 主题管理器
class ThemeManager extends ChangeNotifier {
  static ThemeManager? _instance;
  static ThemeManager get instance => _instance ??= ThemeManager._();
  
  ThemeManager._();
  
  AppThemeMode _themeMode = AppThemeMode.system;
  AppColorScheme _colorScheme = AppColorScheme.starfleet;
  bool _useSystemAccentColor = false;
  double _textScaleFactor = 1.0;
  bool _enableAnimations = true;
  
  /// 当前主题模式
  AppThemeMode get themeMode => _themeMode;
  
  /// 当前颜色方案
  AppColorScheme get colorScheme => _colorScheme;
  
  /// 是否使用系统强调色
  bool get useSystemAccentColor => _useSystemAccentColor;
  
  /// 文本缩放因子
  double get textScaleFactor => _textScaleFactor;
  
  /// 是否启用动画
  bool get enableAnimations => _enableAnimations;
  
  /// 初始化主题管理器
  Future<void> initialize() async {
    await _loadSettings();
  }
  
  /// 加载设置
  Future<void> _loadSettings() async {
    try {
      final themeMode = await CacheManager.getPersistent<String>('theme_mode');
      if (themeMode != null) {
        _themeMode = _parseThemeMode(themeMode);
      }
      
      final colorScheme = await CacheManager.getPersistent<String>('color_scheme');
      if (colorScheme != null) {
        _colorScheme = _parseColorScheme(colorScheme);
      }
      
      final useSystemAccentColor = await CacheManager.getPersistent<bool>('use_system_accent_color');
      if (useSystemAccentColor != null) {
        _useSystemAccentColor = useSystemAccentColor;
      }
      
      final textScaleFactor = await CacheManager.getPersistent<double>('text_scale_factor');
      if (textScaleFactor != null) {
        _textScaleFactor = textScaleFactor;
      }
      
      final enableAnimations = await CacheManager.getPersistent<bool>('enable_animations');
      if (enableAnimations != null) {
        _enableAnimations = enableAnimations;
      }
    } catch (e) {
      // 使用默认设置
    }
  }
  
  /// 保存设置
  Future<void> _saveSettings() async {
    await CacheManager.setPersistent('theme_mode', _themeMode.name);
    await CacheManager.setPersistent('color_scheme', _colorScheme.name);
    await CacheManager.setPersistent('use_system_accent_color', _useSystemAccentColor);
    await CacheManager.setPersistent('text_scale_factor', _textScaleFactor);
    await CacheManager.setPersistent('enable_animations', _enableAnimations);
  }
  
  /// 设置主题模式
  Future<void> setThemeMode(AppThemeMode mode) async {
    if (_themeMode != mode) {
      _themeMode = mode;
      await _saveSettings();
      notifyListeners();
    }
  }
  
  /// 设置颜色方案
  Future<void> setColorScheme(AppColorScheme scheme) async {
    if (_colorScheme != scheme) {
      _colorScheme = scheme;
      await _saveSettings();
      notifyListeners();
    }
  }
  
  /// 设置是否使用系统强调色
  Future<void> setUseSystemAccentColor(bool use) async {
    if (_useSystemAccentColor != use) {
      _useSystemAccentColor = use;
      await _saveSettings();
      notifyListeners();
    }
  }
  
  /// 设置文本缩放因子
  Future<void> setTextScaleFactor(double factor) async {
    if (_textScaleFactor != factor) {
      _textScaleFactor = factor.clamp(0.8, 2.0);
      await _saveSettings();
      notifyListeners();
    }
  }
  
  /// 设置是否启用动画
  Future<void> setEnableAnimations(bool enable) async {
    if (_enableAnimations != enable) {
      _enableAnimations = enable;
      await _saveSettings();
      notifyListeners();
    }
  }
  
  /// 获取Flutter主题模式
  ThemeMode get flutterThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
  
  /// 获取亮色主题
  ThemeData get lightTheme {
    final colorScheme = _getColorScheme(false);
    return _buildTheme(colorScheme, false);
  }
  
  /// 获取暗色主题
  ThemeData get darkTheme {
    final colorScheme = _getColorScheme(true);
    return _buildTheme(colorScheme, true);
  }
  
  /// 构建主题
  ThemeData _buildTheme(ColorScheme colorScheme, bool isDark) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Roboto',
      
      // 应用栏主题
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      
      // 卡片主题
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      
      // 按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      // 文本按钮主题
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      // 输入框主题
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      
      // 列表瓦片主题
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
      
      // 底部导航栏主题
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withOpacity(0.6),
      ),
      
      // 导航栏主题
      navigationBarTheme: NavigationBarThemeData(
        elevation: 8,
        indicatorColor: colorScheme.primaryContainer,
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 12, color: colorScheme.onSurface),
        ),
      ),
      
      // 对话框主题
      dialogTheme: const DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        elevation: 8,
      ),
      
      // 底部表单主题
      bottomSheetTheme: BottomSheetThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        elevation: 8,
      ),
      
      // 分割线主题
      dividerTheme: DividerThemeData(
        color: colorScheme.outline.withOpacity(0.2),
        thickness: 1,
      ),
      
      // 图标主题
      iconTheme: IconThemeData(
        color: colorScheme.onSurface,
        size: 24,
      ),
      
      // 文本主题
      textTheme: _buildTextTheme(colorScheme),
      
      // 动画持续时间
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: _enableAnimations
              ? const CupertinoPageTransitionsBuilder()
              : const FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: _enableAnimations
              ? const CupertinoPageTransitionsBuilder()
              : const FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
  
  /// 构建文本主题
  TextTheme _buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 57 * _textScaleFactor,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      displayMedium: TextStyle(
        fontSize: 45 * _textScaleFactor,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      displaySmall: TextStyle(
        fontSize: 36 * _textScaleFactor,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      headlineLarge: TextStyle(
        fontSize: 32 * _textScaleFactor,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: 28 * _textScaleFactor,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: 24 * _textScaleFactor,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 22 * _textScaleFactor,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 16 * _textScaleFactor,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      titleSmall: TextStyle(
        fontSize: 14 * _textScaleFactor,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontSize: 16 * _textScaleFactor,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 14 * _textScaleFactor,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      bodySmall: TextStyle(
        fontSize: 12 * _textScaleFactor,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface.withOpacity(0.8),
      ),
      labelLarge: TextStyle(
        fontSize: 14 * _textScaleFactor,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      labelMedium: TextStyle(
        fontSize: 12 * _textScaleFactor,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      labelSmall: TextStyle(
        fontSize: 11 * _textScaleFactor,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface.withOpacity(0.8),
      ),
    );
  }
  
  /// 获取颜色方案
  ColorScheme _getColorScheme(bool isDark) {
    switch (_colorScheme) {
      case AppColorScheme.starfleet:
        return _getStarfleetColorScheme(isDark);
      case AppColorScheme.enterprise:
        return _getEnterpriseColorScheme(isDark);
      case AppColorScheme.klingon:
        return _getKlingonColorScheme(isDark);
      case AppColorScheme.vulcan:
        return _getVulcanColorScheme(isDark);
      case AppColorScheme.romulan:
        return _getRomulanColorScheme(isDark);
    }
  }
  
  /// 星际舰队配色方案
  ColorScheme _getStarfleetColorScheme(bool isDark) {
    if (isDark) {
      return const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF4FC3F7),
        onPrimary: Color(0xFF000000),
        secondary: Color(0xFF81C784),
        onSecondary: Color(0xFF000000),
        error: Color(0xFFCF6679),
        onError: Color(0xFF000000),
        surface: Color(0xFF121212),
        onSurface: Color(0xFFFFFFFF),
      );
    } else {
      return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF0277BD),
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFF388E3C),
        onSecondary: Color(0xFFFFFFFF),
        error: Color(0xFFB00020),
        onError: Color(0xFFFFFFFF),
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFF000000),
      );
    }
  }
  
  /// 企业号配色方案
  ColorScheme _getEnterpriseColorScheme(bool isDark) {
    if (isDark) {
      return const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFEF5350),
        onPrimary: Color(0xFF000000),
        secondary: Color(0xFFFFB74D),
        onSecondary: Color(0xFF000000),
        error: Color(0xFFCF6679),
        onError: Color(0xFF000000),
        surface: Color(0xFF121212),
        onSurface: Color(0xFFFFFFFF),
      );
    } else {
      return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFD32F2F),
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFFFF8F00),
        onSecondary: Color(0xFFFFFFFF),
        error: Color(0xFFB00020),
        onError: Color(0xFFFFFFFF),
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFF000000),
      );
    }
  }
  
  /// 克林贡配色方案
  ColorScheme _getKlingonColorScheme(bool isDark) {
    if (isDark) {
      return const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF757575),
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFFD32F2F),
        onSecondary: Color(0xFFFFFFFF),
        error: Color(0xFFCF6679),
        onError: Color(0xFF000000),
        surface: Color(0xFF121212),
        onSurface: Color(0xFFFFFFFF),
      );
    } else {
      return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF424242),
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFFB71C1C),
        onSecondary: Color(0xFFFFFFFF),
        error: Color(0xFFB00020),
        onError: Color(0xFFFFFFFF),
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFF000000),
      );
    }
  }
  
  /// 瓦肯配色方案
  ColorScheme _getVulcanColorScheme(bool isDark) {
    if (isDark) {
      return const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF81C784),
        onPrimary: Color(0xFF000000),
        secondary: Color(0xFF9CCC65),
        onSecondary: Color(0xFF000000),
        error: Color(0xFFCF6679),
        onError: Color(0xFF000000),
        surface: Color(0xFF121212),
        onSurface: Color(0xFFFFFFFF),
      );
    } else {
      return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF2E7D32),
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFF689F38),
        onSecondary: Color(0xFFFFFFFF),
        error: Color(0xFFB00020),
        onError: Color(0xFFFFFFFF),
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFF000000),
      );
    }
  }
  
  /// 罗慕兰配色方案
  ColorScheme _getRomulanColorScheme(bool isDark) {
    if (isDark) {
      return const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFBA68C8),
        onPrimary: Color(0xFF000000),
        secondary: Color(0xFF9575CD),
        onSecondary: Color(0xFFFFFFFF),
        error: Color(0xFFCF6679),
        onError: Color(0xFF000000),
        surface: Color(0xFF121212),
        onSurface: Color(0xFFFFFFFF),
      );
    } else {
      return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF7B1FA2),
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFF512DA8),
        onSecondary: Color(0xFFFFFFFF),
        error: Color(0xFFB00020),
        onError: Color(0xFFFFFFFF),
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFF000000),
      );
    }
  }
  
  /// 解析主题模式
  AppThemeMode _parseThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      case 'system':
      default:
        return AppThemeMode.system;
    }
  }
  
  /// 解析颜色方案
  AppColorScheme _parseColorScheme(String scheme) {
    switch (scheme) {
      case 'enterprise':
        return AppColorScheme.enterprise;
      case 'klingon':
        return AppColorScheme.klingon;
      case 'vulcan':
        return AppColorScheme.vulcan;
      case 'romulan':
        return AppColorScheme.romulan;
      case 'starfleet':
      default:
        return AppColorScheme.starfleet;
    }
  }
}