import 'package:flutter/material.dart';

/// 可访问性工具类
class AccessibilityUtils {
  /// 为Widget添加语义标签
  static Widget addSemantics({
    required Widget child,
    String? label,
    String? hint,
    String? value,
    bool? button,
    bool? header,
    bool? textField,
    bool? focusable,
    VoidCallback? onTap,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      value: value,
      button: button ?? false,
      header: header ?? false,
      textField: textField ?? false,
      focusable: focusable ?? true,
      onTap: onTap,
      child: child,
    );
  }
  
  /// 创建可访问的按钮
  static Widget accessibleButton({
    required Widget child,
    required VoidCallback onPressed,
    required String semanticLabel,
    String? tooltip,
    ButtonStyle? style,
  }) {
    return Semantics(
      label: semanticLabel,
      button: true,
      enabled: true,
      child: Tooltip(
        message: tooltip ?? semanticLabel,
        child: ElevatedButton(
          onPressed: onPressed,
          style: style,
          child: child,
        ),
      ),
    );
  }
  
  /// 创建可访问的文本输入框
  static Widget accessibleTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    String? errorText,
    bool obscureText = false,
    TextInputType? keyboardType,
    ValueChanged<String>? onChanged,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      textField: true,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          errorText: errorText,
          border: const OutlineInputBorder(),
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
      ),
    );
  }
  
  /// 创建可访问的图片
  static Widget accessibleImage({
    required ImageProvider image,
    required String semanticLabel,
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return Semantics(
      label: semanticLabel,
      image: true,
      child: Image(
        image: image,
        width: width,
        height: height,
        fit: fit,
        semanticLabel: semanticLabel,
      ),
    );
  }
  
  /// 创建可访问的列表项
  static Widget accessibleListTile({
    required Widget title,
    Widget? subtitle,
    Widget? leading,
    Widget? trailing,
    required String semanticLabel,
    VoidCallback? onTap,
    bool selected = false,
  }) {
    return Semantics(
      label: semanticLabel,
      button: onTap != null,
      selected: selected,
      child: ListTile(
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        onTap: onTap,
        selected: selected,
      ),
    );
  }
  
  /// 创建可访问的进度指示器
  static Widget accessibleProgressIndicator({
    required double value,
    required String label,
    Color? backgroundColor,
    Color? valueColor,
  }) {
    final percentage = (value * 100).round();
    return Semantics(
      label: '$label: $percentage%',
      value: '$percentage%',
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: backgroundColor,
        valueColor: valueColor != null ? AlwaysStoppedAnimation(valueColor) : null,
      ),
    );
  }
  
  /// 创建可访问的标签页
  static Widget accessibleTab({
    required String text,
    required String semanticLabel,
    Widget? icon,
  }) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: Tab(
        text: text,
        icon: icon,
      ),
    );
  }
  
  /// 创建可访问的开关
  static Widget accessibleSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
    required String label,
    String? activeLabel,
    String? inactiveLabel,
  }) {
    final currentLabel = value 
        ? (activeLabel ?? '$label 已开启')
        : (inactiveLabel ?? '$label 已关闭');
    
    return Semantics(
      label: currentLabel,
      toggled: value,
      child: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
  
  /// 创建可访问的滑块
  static Widget accessibleSlider({
    required double value,
    required ValueChanged<double> onChanged,
    required String label,
    double min = 0.0,
    double max = 1.0,
    int? divisions,
  }) {
    final percentage = ((value - min) / (max - min) * 100).round();
    
    return Semantics(
      label: '$label: $percentage%',
      value: '$percentage%',
      slider: true,
      child: Slider(
        value: value,
        onChanged: onChanged,
        min: min,
        max: max,
        divisions: divisions,
      ),
    );
  }
  
  /// 检查是否启用了可访问性服务
  static bool isAccessibilityEnabled(BuildContext context) {
    return MediaQuery.of(context).accessibleNavigation;
  }
  
  /// 获取推荐的触摸目标大小
  static double getMinimumTouchTargetSize() {
    return 48.0; // Material Design 推荐的最小触摸目标大小
  }
  
  /// 确保触摸目标大小符合可访问性要求
  static Widget ensureMinimumTouchTarget({
    required Widget child,
    double? minWidth,
    double? minHeight,
  }) {
    final minSize = getMinimumTouchTargetSize();
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? minSize,
        minHeight: minHeight ?? minSize,
      ),
      child: child,
    );
  }
  
  /// 创建可访问的对话框
  static Future<T?> showAccessibleDialog<T>({
    required BuildContext context,
    required Widget child,
    required String title,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => Semantics(
        label: '对话框: $title',
        child: AlertDialog(
          title: Text(title),
          content: child,
        ),
      ),
    );
  }
}

/// 可访问性Mixin
mixin AccessibilityMixin<T extends StatefulWidget> on State<T> {
  /// 检查当前是否启用了可访问性
  bool get isAccessibilityEnabled => AccessibilityUtils.isAccessibilityEnabled(context);
  
  /// 为子类提供便捷的语义包装方法
  Widget wrapWithSemantics({
    required Widget child,
    required String label,
    String? hint,
    bool? button,
    VoidCallback? onTap,
  }) {
    return AccessibilityUtils.addSemantics(
      child: child,
      label: label,
      hint: hint,
      button: button,
      onTap: onTap,
    );
  }
}