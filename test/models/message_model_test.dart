import 'package:flutter_test/flutter_test.dart';
import 'package:flugo_app/features/chat/data/models/message_model.dart';

void main() {
  group('Message Model Tests', () {
    test('fromMap should create message correctly', () {
      // Arrange
      final map = {
        'text': 'Hello, world!',
        'userId': 'user123',
        'userName': 'John Doe',
        'timestamp': 1708123456789,
      };

      // Act
      final message = Message.fromMap('msg1', map);

      // Assert
      expect(message.id, 'msg1');
      expect(message.text, 'Hello, world!');
      expect(message.userId, 'user123');
      expect(message.userName, 'John Doe');
      expect(message.timestamp, DateTime.fromMillisecondsSinceEpoch(1708123456789));
    });

    test('fromMap should use default values when data is missing', () {
      // Arrange
      final map = <String, dynamic>{};

      // Act
      final message = Message.fromMap('msg2', map);

      // Assert
      expect(message.id, 'msg2');
      expect(message.text, '');
      expect(message.userId, '');
      expect(message.userName, 'Usuário');
      expect(message.timestamp, DateTime.fromMillisecondsSinceEpoch(0));
    });

    test('toMap should convert message to Map correctly', () {
      // Arrange
      final timestamp = DateTime(2024, 2, 17, 10, 30);
      final message = Message(
        id: 'msg1',
        text: 'Hello!',
        userId: 'user1',
        userName: 'Mary Smith',
        timestamp: timestamp,
      );

      // Act
      final map = message.toMap();

      // Assert
      expect(map['text'], 'Hello!');
      expect(map['userId'], 'user1');
      expect(map['userName'], 'Mary Smith');
      expect(map['timestamp'], timestamp.millisecondsSinceEpoch);
      expect(map.containsKey('id'), false);
    });

    test('copyWith should create new message with updated values', () {
      // Arrange
      final original = Message(
        id: 'msg1',
        text: 'Original text',
        userId: 'user1',
        userName: 'John',
        timestamp: DateTime(2024, 2, 17),
      );

      // Act
      final copied = original.copyWith(
        text: 'Updated text',
        userName: 'John Doe',
      );

      // Assert
      expect(copied.id, 'msg1');
      expect(copied.text, 'Updated text');
      expect(copied.userId, 'user1');
      expect(copied.userName, 'John Doe');
      expect(copied.timestamp, original.timestamp);
    });

    test('copyWith without parameters should return identical copy', () {
      // Arrange
      final original = Message(
        id: 'msg1',
        text: 'Test',
        userId: 'user1',
        userName: 'Test User',
        timestamp: DateTime(2024, 2, 17),
      );

      // Act
      final copied = original.copyWith();

      // Assert
      expect(copied.id, original.id);
      expect(copied.text, original.text);
      expect(copied.userId, original.userId);
      expect(copied.userName, original.userName);
      expect(copied.timestamp, original.timestamp);
    });
  });
}
