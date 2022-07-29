import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const baseURLString = 'https://westmarket.herokuapp.com/api/v1';

class NetworkHelper {
  /// Function to register a new user
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    Uri url = Uri.parse('$baseURLString/user/register');
    var response = await http.post(
      url,
      body: {'name': name, 'email': email, 'password': password},
    );
    Map<String, dynamic> jsonResponse = await jsonDecode(response.body);
    return jsonResponse;
    // TODO: Specify responses for different case scenarios
  }

  Future<Map<String, dynamic>> verifyEmail(
      {required String email, required String otp}) async {
    Uri url = Uri.parse('$baseURLString/user/verify-email');
    http.Response response = await http.post(
      url,
      body: {'email': email, 'otp': otp},
    );
    Map<String, dynamic> jsonResponse = await jsonDecode(response.body);
    return jsonResponse;
  }

  login() {}

  Future<dynamic> getResponse(Uri url) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = response.body;
        var decodedData = jsonDecode(data);
        return decodedData;
      } else {
        // print(response.statusCode);
        return;
      }
    } catch (e) {
      // print(e.toString());
      return;
    }
  }
}
