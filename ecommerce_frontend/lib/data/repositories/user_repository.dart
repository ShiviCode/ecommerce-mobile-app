// take dta from api and convert into models like services 

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_mobile_app/core/api.dart';
import 'package:ecommerce_mobile_app/data/models/user_model.dart';

class UserRepository {
// service from GetIt
// more like ApiHelper
  final Api _api = Api();


  Future<UserModel> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _api.sendRequestDio.post(
        "/user/createAccount",
        //User input model for create account and covert it to json encode fromt the class
        data: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.success) {
        // return apiResponse(json) to user model;
        return UserModel.fromJson(apiResponse.data);
      }
      // if success false throwing error
      throw apiResponse.message.toString();
    } catch (ex) {
      rethrow;
    }
  }


  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _api.sendRequestDio.post(
        "/user/signIn",
        //User input model for create account and covert it to json encode fromt the class
        data: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.success) {
        // return apiResponse(json) to user model;
        return UserModel.fromJson(apiResponse.data);
      }
      // if success false throwing error
      throw apiResponse.message.toString();
    } catch (ex) {
      rethrow;
    }
  }
}
