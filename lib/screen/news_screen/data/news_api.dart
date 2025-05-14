
import 'dart:convert';

import 'package:flutter/services.dart';

sealed class NewsApi{

  static Future<String>loadApiKey()async{
    final loadString = await rootBundle.loadString("assets/secrets/secret_news.json");
    final map = jsonDecode(loadString);
    return map['api_key'];
  }
}