import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MistralService {
  final Dio _dio = Dio();
  final String apiKey = dotenv.env['MISTRAL_API_KEY'] ?? '';

  Future<String> sendMessage(String message) async {
    try {
      Response response = await _dio.post(
        'https://api.mistral.ai/v1/chat/completions',
        options: Options(headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        }),
        data: {
          'model': 'mistral-7b',
          'messages': [
            {'role': 'user', 'content': message}
          ]
        },
      );

      return response.data['choices'][0]['message']['content'];
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}
