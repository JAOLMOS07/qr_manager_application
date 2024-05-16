import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qr_manager_application/domain/models/content.dart';

class ContentService {
  static const String apiUrl = 'https://localhost:7001/Content';

  Future<List<Content>> fetchContents() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((json) => Content.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load contents');
    }
  }

  Future<void> createContent(String title, String description, String logo,
      List<String> multimedia) async {
    final Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'logo': logo,
      'multimedia': multimedia,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 202) {
      throw Exception('Failed to create content');
    }
  }
}
