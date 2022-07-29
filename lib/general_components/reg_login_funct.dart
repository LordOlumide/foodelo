import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const baseURLString = 'https://westmarket.herokuapp.com/api/v1';

register(
  String name,
  String email,
  String password,
) async {
  Uri url = Uri.parse('$baseURLString/user/register');
  var response = await http.post(
    url,
    body: {
      'name': name,
      'email': email,
      'password': password,
    },
  );
  if (response.statusCode != 200) {
    throw 'Something went wrong. Try again.';
  }
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}

Future<dynamic> getResponse({Uri url}) async {
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