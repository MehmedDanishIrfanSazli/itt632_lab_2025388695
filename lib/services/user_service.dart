import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  static final Uri endpoint = Uri.parse('https://jsonplaceholder.typicode.com/users');

  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(endpoint).timeout(const Duration(seconds: 15));
      if (response.statusCode != 200) {
        throw Exception('Server returned status code ${response.statusCode}.');
      }
      // Only parse a successful HTTP response.
      final decoded = jsonDecode(response.body);
      if (decoded is! List) {
        throw const FormatException('Expected a list of users.');
      }
      return decoded.map((entry) => User.fromJson(entry as Map<String, dynamic>)).toList();
    } on FormatException {
      throw Exception('The server sent invalid user data. Please retry.');
    } on http.ClientException {
      throw Exception('Connection failed. Check your internet connection and retry.');
    }
  }
}
