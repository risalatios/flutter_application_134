import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_application_134/TabbarForApp/SessionManager.dart';

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
  String? token = await SessionManager.getToken();
   print("token: $token");
  return await dio.post(
    url,
    data: data,
    options: Options(headers: {
      'TOKEN': '$token', // Add the token to the headers
      'Content-Type': 'application/json', // Example content type, adjust as needed
    }),
  );
}

Future<Response> postHomeDataNew(String url) async {
  String? token = await SessionManager.getToken();
   print("token: $token");
  return await dio.post(
    url,
    options: Options(headers: {
      'TOKEN': '$token', // Add the token to the headers
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