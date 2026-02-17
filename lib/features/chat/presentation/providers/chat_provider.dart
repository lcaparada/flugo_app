import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import '../../data/models/message_model.dart';

class ChatProvider extends ChangeNotifier {
  final DatabaseReference _messagesRef = FirebaseDatabase.instance.ref().child(
    'messages',
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Message> _messages = [];
  bool _isLoading = false;
  bool _isSending = false;
  String? _errorMessage;
  StreamSubscription<DatabaseEvent>? _messagesSubscription;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;
  bool get isSending => _isSending;
  String? get errorMessage => _errorMessage;

  ChatProvider() {
    _initializeChat();
  }

  void _initializeChat() {
    _isLoading = true;
    notifyListeners();

    _messagesSubscription?.cancel();

    _messagesSubscription = _messagesRef.onValue.listen(
      (DatabaseEvent event) {
        final data = event.snapshot.value;

        if (data == null) {
          _messages = [];
          _isLoading = false;
          notifyListeners();
          return;
        }

        final Map<dynamic, dynamic> messagesMap = data as Map<dynamic, dynamic>;
        final List<Message> loadedMessages = [];

        messagesMap.forEach((key, value) {
          if (value is Map) {
            loadedMessages.add(Message.fromMap(key, value));
          }
        });

        loadedMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

        _messages = loadedMessages;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = 'Erro ao carregar mensagens: $error';
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<bool> sendMessage(String text) async {
    if (text.trim().isEmpty) {
      return false;
    }

    final user = _auth.currentUser;
    if (user == null) {
      _errorMessage = 'Usuário não autenticado';
      notifyListeners();
      return false;
    }

    try {
      _isSending = true;
      _errorMessage = null;
      notifyListeners();

      final message = Message(
        id: _messagesRef.push().key ?? DateTime.now().toString(),
        text: text.trim(),
        userId: user.uid,
        userName: user.displayName ?? 'Usuário',
        timestamp: DateTime.now(),
      );

      await _messagesRef.child(message.id).set(message.toMap());

      _isSending = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Erro ao enviar mensagem: $e';
      _isSending = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    super.dispose();
  }
}
