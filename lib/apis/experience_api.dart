import 'package:http/http.dart' as http;
import 'dart:convert';

class ExperienceApiProvider {
  static const baseUrl = 'https://api-gateway-peterhensk.cloud.okteto.net/experience';

  Future<List<Experience>> fetchExperience() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      final List<Experience> experienceList =
      jsonList.map((json) => Experience.fromJson(json)).toList();
      return experienceList;
    } else {
      throw Exception('Failed to load experience data');
    }
  }
}

class Experience {
  final String id;
  final String title;
  final String description;
  final String? published;
  final String? projectUrl;

  Experience({
    required this.id,
    required this.title,
    required this.description,
    required this.published,
    required this.projectUrl,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      published: json['published'],
      projectUrl: json['projectUrl'],
    );
  }
}
