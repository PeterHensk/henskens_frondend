import 'package:http/http.dart' as http;

class ApiProvider {
  static const baseUrl = 'https://api-gateway-peterhensk.cloud.okteto.net/account/';

  Future<http.Response> fetchData(String email) async {
    final response = await http.get(Uri.parse(baseUrl + email));
    return response;
  }
}
