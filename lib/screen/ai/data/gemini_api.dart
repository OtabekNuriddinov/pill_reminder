import 'dart:convert';

import 'package:flutter/services.dart';

sealed class GeminiApi{

  static Future<String> loadApiKey()async{
    final jsonString = await rootBundle.loadString('assets/secrets/secret.json');
    final jsonMap = jsonDecode(jsonString);
    return jsonMap['api_key'];
  }
}