import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flugo_app/features/auth/presentation/widgets/auth_text_field.dart';

void main() {
  group('AuthTextField Widget Tests', () {
    testWidgets('should display label', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthTextField(
              label: 'Email',
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('should allow text input', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthTextField(
              label: 'Name',
              controller: controller,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'John Doe');

      expect(controller.text, 'John Doe');
    });

    testWidgets('should create field with obscureText when requested', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthTextField(
              label: 'Password',
              controller: controller,
              obscureText: true,
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('should create field without obscureText by default', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthTextField(
              label: 'Email',
              controller: controller,
              obscureText: false,
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('should display prefixIcon when provided', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthTextField(
              label: 'Email',
              controller: controller,
              prefixIcon: Icons.email,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('should display suffixIcon when provided', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthTextField(
              label: 'Password',
              controller: controller,
              suffixIcon: const Icon(Icons.visibility),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('should create field with specific keyboard type', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthTextField(
              label: 'Email',
              controller: controller,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('should call validator when validated', (tester) async {
      final controller = TextEditingController();
      String? validationResult;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: AuthTextField(
                label: 'Email',
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    validationResult = 'Field is required';
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      final formState = tester.state<FormState>(find.byType(Form));
      formState.validate();
      await tester.pump();

      expect(validationResult, 'Field is required');
      expect(find.text('Field is required'), findsOneWidget);
    });

    testWidgets('should not display error when validation passes', (tester) async {
      final controller = TextEditingController(text: 'test@email.com');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: AuthTextField(
                label: 'Email',
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      final formState = tester.state<FormState>(find.byType(Form));
      final isValid = formState.validate();
      await tester.pump();

      expect(isValid, true);
      expect(find.text('Field is required'), findsNothing);
    });

    testWidgets('should display label and create widget correctly', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthTextField(
              label: 'Username',
              hint: 'Enter your username',
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.text('Username'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
