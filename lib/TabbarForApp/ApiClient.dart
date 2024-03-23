import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio();
  }

  Future<Response> get(String url) async {
    return await dio.get(url);
  }

  Future<Response> post(String url, dynamic data) async {
    return await dio.post(url, data: json.encode(data));
  }

  Future<Response> postWithToken(String url, dynamic data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  print("token: $token");
  
  return await dio.post(
    url,
    data: data,
    options: Options(headers: {
      'Authorization': 'Bearer $token', // Add the token to the headers
      'Content-Type': 'application/json', // Example content type, adjust as needed
    }),
  );
}


  Future<Response> put(String url, dynamic data) async {
    return await dio.put(url, data: data);
  }

  Future<Response> delete(String url) async {
    return await dio.delete(url);
  }
}