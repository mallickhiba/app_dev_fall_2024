import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String baseUrl = "https://newsapi.org/v2/top-headlines?country=us";
  final String apiKey = "abb021fcd9124fe4a756d19365dc0136";

  Future<List<dynamic>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl&apiKey=$apiKey'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['articles'];
      } else {
        throw Exception("Failed to load news");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
