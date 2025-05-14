import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService{

  final String apiKey;
  AIService({required this.apiKey});

  Future<String> generateContent(String prompt)async{
    final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',);

    final content = {
      'contents': [
        {
          'parts': [
            {'text': prompt}
          ],
          'role': 'user'
        }
      ]
    };

    final body = jsonEncode(content);

    final response = await http.post(
       url,
      headers: {'Content-Type': 'application/json'},
      body: body
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final text = data['candidates'][0]['content']['parts'][0]['text'];
      return text ?? "No Response";
    }
    else{
      throw Exception("API Error: ${response.statusCode}");
    }
  }
}
