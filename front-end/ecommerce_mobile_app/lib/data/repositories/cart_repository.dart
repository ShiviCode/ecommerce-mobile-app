// take dta from api and convert into models like services

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_mobile_app/core/api.dart';
import 'package:ecommerce_mobile_app/data/models/cart_item_model.dart';

class CartRepository {
// service from GetIt
// more like ApiHelper
  final Api _api = Api();

  Future<List<CartItemModel>> fetchCartForUser(String userId) async {
    try {
      Response response = await _api.sendRequestDio.get(
        "/cart/$userId",
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.success) {
        // return apiResponse(json) to CartItemModel;

        // Iterable listJson = json.decode(apiResponse.data);
        // ApiResponse decodes it by itself

        Iterable listJson = apiResponse.data;
        List<CartItemModel> list =
            listJson.map((e) => CartItemModel.fromJson(e)).toList();

        // CartItemModel.fromJson(apiResponse.data);
        return list;

        // return (apiResponse.data as List<dynamic>).map((e) => CartItemModel.fromJson(e)).toList();
      }
      // if success false throwing error
      throw apiResponse.message.toString();
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<CartItemModel>> addToCart(
      CartItemModel cartItem, String userId) async {
    try {
      // Adding user id to cart item data model
      Map<String, dynamic> data = cartItem.toJson();
      data["user"] = userId;

      Response response = await _api.sendRequestDio.post(
        "/cart",
        data: jsonEncode(data),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.success) {
        // return apiResponse(json) to CartItemModel;

        // Iterable listJson = json.decode(apiResponse.data);
        // ApiResponse decodes it by itself

        Iterable listJson = apiResponse.data;
        List<CartItemModel> list =
            listJson.map((e) => CartItemModel.fromJson(e)).toList();

        // CartItemModel.fromJson(apiResponse.data);
        return list;

        // return (apiResponse.data as List<dynamic>).map((e) => CartItemModel.fromJson(e)).toList();
      }
      // if success false throwing error
      throw apiResponse.message.toString();
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<CartItemModel>> removeFromCart(
      String userId, String productId) async {
    try {
      // Adding user id to cart item data model
      Map<String, dynamic> data = {
        "product": productId,
        "user": userId,
      };

      Response response = await _api.sendRequestDio.delete(
        "/cart",
        data: data,
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.success) {
        // return apiResponse(json) to CartItemModel;

        // Iterable listJson = json.decode(apiResponse.data);
        // ApiResponse decodes it by itself

        Iterable listJson = apiResponse.data;
        List<CartItemModel> list =
            listJson.map((e) => CartItemModel.fromJson(e)).toList();

        // CartItemModel.fromJson(apiResponse.data);
        return list;

        // return (apiResponse.data as List<dynamic>).map((e) => CartItemModel.fromJson(e)).toList();
      }
      // if success false throwing error
      throw apiResponse.message.toString();
    } catch (ex) {
      rethrow;
    }
  }
}
