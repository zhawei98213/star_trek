import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:start_trek/features/home/presentation/widgets/home_header.dart';

void main() {
  group('HomeHeader Widget Tests', () {
    testWidgets('should display user name correctly', (tester) async {
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const HomeHeader(),
          ),
        ),
      );
      
      // assert
      expect(find.textContaining('欢迎回来'), findsOneWidget);
    });
    
    testWidgets('should display greeting message', (tester) async {
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const HomeHeader(),
          ),
        ),
      );
      
      // assert
      expect(find.textContaining('今天想学点什么'), findsOneWidget);
    });
    
    testWidgets('should have proper accessibility semantics', (tester) async {
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const HomeHeader(),
          ),
        ),
      );
      
      // assert
      final semantics = tester.getSemantics(find.byType(HomeHeader));
      expect(semantics.label, contains('欢迎'));
    });
  });
}