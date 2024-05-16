import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qr_manager_application/domain/models/content.dart';
import 'package:qr_manager_application/domain/models/link.dart';

class LinkService {
  static const String apiUrl = 'https://localhost:7001/Link';

  Future<List<Link>> fetchLinks() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Link.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load links');
    }
  }

  Future<void> createLink(int subscriptionType) async {
    final Map<String, dynamic> linkData = {
      'subscriptionType': subscriptionType,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(linkData),
    );

    if (response.statusCode != 202) {
      throw Exception('Failed to create link');
    }
  }

  Future<void> assignContent(Link link, Content content) async {
    final Map<String, dynamic> linkData = {
      'contentId': content.id,
    };

    final response = await http.patch(
      Uri.parse("$apiUrl/${link.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(linkData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create link');
    }
  }
}
