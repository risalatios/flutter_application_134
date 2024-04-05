import 'dart:convert';
import 'package:flutter_application_134/TabbarForApp/ApiClient.dart';
import 'package:flutter_application_134/TabbarForApp/ApiEndPoint.dart';


class LoginController{

  final ApiClient apiClient=ApiClient();

  Future<Map<String,dynamic>> generateOtp(String phoneNumber)async{
   final response= await apiClient.post(EndPoints.BaseUrlLive+EndPoints.GenerateOtp, {'phone':phoneNumber}) ;
   return jsonDecode(response.toString());
  }

  Future<Map<String,dynamic>> verifyOtp(String phoneNumber,String otp)async{
    final response= await apiClient.post(EndPoints.BaseUrlLive+EndPoints.VerifyOtp, {'phone':phoneNumber,'pin':otp,'platform':"ios"});
    return jsonDecode(response.toString());
  }

  Future<Map<String,dynamic>> getHomeDataNEw()async{
    final response= await apiClient.postHomeDataNew(EndPoints.BaseUrlLive+EndPoints.GetHomeDataLive);
    return jsonDecode(response.toString());
  }

  Future<Map<String, dynamic>> getHomeData() async {
  final requestData = {
    'limit': 100,
    'offset': 0,
    'title': "Latest Products",
    'filter_ids': {}, 
  };

  final response = await apiClient.postWithToken(
    EndPoints.BaseUrl + EndPoints.GetHomeData,
    requestData,
  );
  return jsonDecode(response.toString());
}

}

LoginController loginController=LoginController();