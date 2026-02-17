import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flugo_app/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flugo_app/features/chat/data/models/message_model.dart';

void main() {
  group('MessageBubble Widget Tests', () {
    testWidgets('should display message text', (tester) async {
      final message = Message(
        id: '1',
        text: 'Hello, world!',
        userId: 'user1',
        userName: 'John',
        timestamp: DateTime(2024, 2, 17, 10, 30),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageBubble(
              message: message,
              isCurrentUser: false,
            ),
          ),
        ),
      );

      expect(find.text('Hello, world!'), findsOneWidget);
    });

    testWidgets('should display user name when not current user message', (tester) async {
      final message = Message(
        id: '1',
        text: 'Test',
        userId: 'user1',
        userName: 'Mary Smith',
        timestamp: DateTime(2024, 2, 17, 10, 30),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageBubble(
              message: message,
              isCurrentUser: false,
            ),
          ),
        ),
      );

      expect(find.text('Mary Smith'), findsOneWidget);
    });

    testWidgets('should not display user name when current user message', (tester) async {
      final message = Message(
        id: '1',
        text: 'My message',
        userId: 'user1',
        userName: 'Myself',
        timestamp: DateTime(2024, 2, 17, 10, 30),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageBubble(
              message: message,
              isCurrentUser: true,
            ),
          ),
        ),
      );

      expect(find.text('Myself'), findsNothing);
      expect(find.text('My message'), findsOneWidget);
    });

    testWidgets('should display formatted time', (tester) async {
      final message = Message(
        id: '1',
        text: 'Time test',
        userId: 'user1',
        userName: 'John',
        timestamp: DateTime(2024, 2, 17, 14, 25),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageBubble(
              message: message,
              isCurrentUser: false,
            ),
          ),
        ),
      );

      expect(find.text('14:25'), findsOneWidget);
    });

    testWidgets('should align to right when current user message', (tester) async {
      final message = Message(
        id: '1',
        text: 'Test',
        userId: 'user1',
        userName: 'Me',
        timestamp: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageBubble(
              message: message,
              isCurrentUser: true,
            ),
          ),
        ),
      );

      final align = tester.widget<Align>(find.byType(Align));
      expect(align.alignment, Alignment.centerRight);
    });

    testWidgets('should align to left when not current user message', (tester) async {
      final message = Message(
        id: '1',
        text: 'Test',
        userId: 'user1',
        userName: 'Other',
        timestamp: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageBubble(
              message: message,
              isCurrentUser: false,
            ),
          ),
        ),
      );

      final align = tester.widget<Align>(find.byType(Align));
      expect(align.alignment, Alignment.centerLeft);
    });
  });
}
