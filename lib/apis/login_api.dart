import 'package:flutter/services.dart' show rootBundle;

class ApiService {
  Future<String?> readTokenFromFile() async {
    try {
      final String token = await rootBundle.loadString('lib/apis/bearer.txt');
      return token;
    } catch (e) {
      print('Error reading token: $e');
      return null;
    }
  }
}

