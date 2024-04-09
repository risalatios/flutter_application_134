import 'package:flutter/material.dart';
import 'package:flutter_application_134/HomeView/Model/HomeApiResponse.dart';
import 'package:flutter_application_134/TabbarForApp/LoginController.dart';

class ViewModel {

late List<Datum> banners = [];
late List<Datum> postProducts = [];
String? state;
String? city;
bool isLoading = false;
late List<Post> posts = [];

}