import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:start_trek/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('App Integration Tests', () {
    testWidgets('complete user flow test', (tester) async {
      // 启动应用
      app.main();
      await tester.pumpAndSettle();
      
      // 等待启动页加载完成
      await tester.pumpAndSettle(const Duration(seconds: 3));
      
      // 验证首页加载成功
      expect(find.text('欢迎回来'), findsOneWidget);
      
      // 测试底部导航
      final learningTab = find.text('学习');
      expect(learningTab, findsOneWidget);
      
      await tester.tap(learningTab);
      await tester.pumpAndSettle();
      
      // 验证学习页面加载
      expect(find.text('我的学习'), findsOneWidget);
      
      // 测试返回首页
      final homeTab = find.text('首页');
      await tester.tap(homeTab);
      await tester.pumpAndSettle();
      
      // 验证返回首页成功
      expect(find.text('欢迎回来'), findsOneWidget);
    });
    
    testWidgets('navigation flow test', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 3));
      
      // 测试快捷操作导航
      final shopButton = find.text('商店');
      if (shopButton.evaluate().isNotEmpty) {
        await tester.tap(shopButton);
        await tester.pumpAndSettle();
        
        // 验证导航成功（这里应该显示商店页面或占位符）
        expect(find.byType(Scaffold), findsOneWidget);
      }
      
      // 返回首页
      await tester.pageBack();
      await tester.pumpAndSettle();
    });
    
    testWidgets('responsive layout test', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 3));
      
      // 测试不同屏幕尺寸
      await tester.binding.setSurfaceSize(const Size(800, 600)); // 平板尺寸
      await tester.pumpAndSettle();
      
      // 验证响应式布局
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 恢复默认尺寸
      await tester.binding.setSurfaceSize(const Size(400, 800)); // 手机尺寸
      await tester.pumpAndSettle();
      
      expect(find.byType(Scaffold), findsOneWidget);
    });
    
    testWidgets('accessibility test', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 3));
      
      // 检查语义是否启用
      final semanticsEnabled = SemanticsBinding.instance.semanticsEnabled;
      expect(semanticsEnabled, isTrue);
      
      // 验证主要元素有适当的语义标签
      expect(find.bySemanticsLabel(RegExp(r'欢迎|首页|导航')), findsWidgets);
    });
  });
}