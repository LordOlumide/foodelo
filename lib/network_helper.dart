import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const baseURLString = 'https://westmarket.herokuapp.com/api/v1';

class NetworkHelper {
  Future<Map<String, dynamic>> registerOnline({
    required String name,
    required String email,
    required String password,
  }) async {
    Uri url = Uri.parse('$baseURLString/user/register');
    var response = await http.post(
      url,
      body: {'name': name, 'email': email, 'password': password},
    );
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse;
    // TODO: Specify responses for different case scenarios
  }

  Future<Map<String, dynamic>> verifyEmailOnline(
      {required String email, required String otp}) async {
    Uri url = Uri.parse('$baseURLString/user/verify-email');
    http.Response response = await http.post(
      url,
      body: {'email': email, 'otp': otp},
    );
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }

  Future<Map<String, dynamic>> loginOnline({
    required String email,
    required String password,
  }) async {
    Uri url = Uri.parse('$baseURLString/user/login');
    var response = await http.post(
      url,
      body: {'email': email, 'password': password},
    );
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse;
// TODO: Specify responses for different case scenarios
  }

  Future<Map<String, dynamic>> requestPasswordResetOnline(
      {required String email}) async {
    Uri url = Uri.parse('$baseURLString/user/password-reset-request');
    var response = await http.post(
      url,
      body: {'email': email},
    );
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse;
// TODO: Specify responses for different case scenarios
  }

  Future<Map<String, dynamic>> resetPasswordOnline({
    required String userId,
    required String otp,
    required String newPassword,
  }) async {
    Uri url = Uri.parse('$baseURLString/user/reset-password');
    var response = await http.post(
      url,
      body: {
        'userId': userId,
        'otp': otp,
        'newPassword': newPassword,
      },
    );
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse;
// TODO: Specify responses for different case scenarios
  }

  // Not working yet
  Future<Map<String, dynamic>> getProductsListOnline(String userId) async {
    Uri url = Uri.parse('$baseURLString/user/$userId/products');
    // Since even the url from the website is Unauthorized, it must be a backend issue.
    // Uri testUrl = Uri.parse('https://westmarket.herokuapp.com/api/v1/user/62b8c3a6c4129240dad01555/products');
    var response = await http.get(url);
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }

  // Untested
  Future<Map<String, dynamic>> addToCartOnline({
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    Uri url = Uri.parse('$baseURLString/user/cart/add-item');
    var response = await http.post(
      url,
      body: {
        'userId': userId,
        'productId': productId,
        'quantity': quantity,
      },
    );
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }

  // untested
  Future<Map<String, dynamic>> getCompleteCartOnline(
      {required String userId}) async {
    Uri url = Uri.parse('$baseURLString/user/$userId/cart');
    var response = await http.get(url);
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
}
