import 'package:flutter/material.dart';
import 'package:medicine_reminder/screen/ai/ai_service/service.dart';

class AINotifier extends ChangeNotifier{

  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  List<Map<String, String>> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String userMessage, String apiKey) async {

      _messages.add({'role': 'user', 'message': userMessage});
      _isLoading = true;
      notifyListeners();

    try {
      final aiService = AIService(apiKey: apiKey);
      final aiReply = await aiService.generateContent(userMessage);
        _messages.add({'role': 'ai', 'message': aiReply});
      notifyListeners();
    } catch (e) {
        _messages.add({'role': 'ai', 'message': 'Error: $e'});
      notifyListeners();
    } finally {
        _isLoading = false;
      notifyListeners();
    }
  }
}