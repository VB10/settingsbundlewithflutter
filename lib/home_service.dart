import 'dart:io';

import 'package:dio/dio.dart';

import 'model/user.dart';

class HomeService {
  final String baseUrl;

  final _dio = Dio();
  HomeService(this.baseUrl);
  Future<User?> getUserData() async {
    final response = await _dio.get('$baseUrl/user.json');
// https://fluttertr-ead5c.firebaseio.com/api/dev/user.json
    if (response.statusCode == HttpStatus.ok) {
      final responseJson = response.data;
      if (responseJson is Map<String, dynamic>) {
        return User.fromJson(responseJson);
      }
    }
    return null;
  }
}
