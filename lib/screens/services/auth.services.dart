import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/user.dart';

class AuthService {
  static const String _baseUrl = 'http://192.168.2.49:8080/api';
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json'
  };

  Future<User> registerUser(
      {required String fullName,
      required String email,
      required String password}) async {
    const String apiUrl = '$_baseUrl/register';

    final body = jsonEncode({
      'full_name': fullName,
      'email': email,
      'password': password,
    });

    final response =
        await http.post(Uri.parse(apiUrl), headers: _headers, body: body);
    print(response.body);
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  Future<User> loginUser(
      {required String email, required String password}) async {
    const String apiUrl = '$_baseUrl/login';

    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    final response =
        await http.post(Uri.parse(apiUrl), headers: _headers, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final user = User.fromJson(responseBody['user']);
      user.token = responseBody['token'];
      // print(user);
      return user;
    } else {
      throw Exception(response.body);
    }
  }
}
