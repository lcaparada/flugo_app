import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flugo_app/core/theme/app_theme.dart';

void main() {
  group('App Theme Tests', () {
    test('should have valid light theme', () {
      final theme = AppTheme.lightTheme;

      expect(theme, isNotNull);
      expect(theme.useMaterial3, true);
    });

    test('should have scaffold background color defined', () {
      final theme = AppTheme.lightTheme;

      expect(theme.scaffoldBackgroundColor, isNotNull);
    });

    test('should have input decoration theme defined', () {
      final theme = AppTheme.lightTheme;

      expect(theme.inputDecorationTheme, isNotNull);
      expect(theme.inputDecorationTheme.filled, true);
    });

    test('should have elevated button theme defined', () {
      final theme = AppTheme.lightTheme;

      expect(theme.elevatedButtonTheme, isNotNull);
    });

    test('should have app bar theme defined', () {
      final theme = AppTheme.lightTheme;

      expect(theme.appBarTheme, isNotNull);
      expect(theme.appBarTheme.centerTitle, true);
    });

    test('should have text theme defined', () {
      final theme = AppTheme.lightTheme;

      expect(theme.textTheme, isNotNull);
      expect(theme.textTheme.displayLarge, isNotNull);
      expect(theme.textTheme.bodyLarge, isNotNull);
    });
  });

  group('Color Scheme Tests', () {
    testWidgets('should apply theme to MaterialApp', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const Scaffold(
            body: Center(
              child: Text('Test'),
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
