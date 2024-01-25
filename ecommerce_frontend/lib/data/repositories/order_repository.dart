// take dta from api and convert into models like services

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_mobile_app/core/api.dart';
import 'package:ecommerce_mobile_app/data/models/order_model.dart';

class OrderRepository {
// service from GetIt
// more like ApiHelper
  final Api _api = Api();

  Future<List<OrderModel>> fetchOrdersForUser(String userId) async {
    try {
      Response response = await _api.sendRequestDio.get(
        "/order/$userId",
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.success) {
        // return apiResponse(json) to OrderModel;

        // Iterable listJson = json.decode(apiResponse.data);
        // ApiResponse decodes it by itself

        Iterable listJson = apiResponse.data;
        List<OrderModel> list =
            listJson.map((e) => OrderModel.fromJson(e)).toList();

        // OrderModel.fromJson(apiResponse.data);
        return list;

        // return (apiResponse.data as List<dynamic>).map((e) => OrderModel.fromJson(e)).toList();
      }
      // if success false throwing error
      throw apiResponse.message.toString();
    } catch (ex) {
      rethrow;
    }
  }

  Future<OrderModel> createOrder(OrderModel orderModel) async {
    try {
      Response response = await _api.sendRequestDio.post(
        "/order",
        data: jsonEncode({
          "user": {
            "fullName": "dummy",
            "email": "dummy@gmail.com",
            "phoneNumber": "1234567890",
            "address": "",
            "city": "",
            "state": "",
            "id": "2ab316f0-b38b-11ee-bf44-0f312800ce72",
            "updatedOn": "2023-12-28T08:18:16.445Z",
            "createdOn": "2023-12-28T08:18:16.445Z"
          },
          "items": [
            {
              "quantity": 1,
              "product": {
                "_id": "65952bb81baafbb3997e37a0",
                "category": "658d4077b5b0be1aaa1031bd",
                "title": "women top",
                "description": "",
                "price": 12999,
                "images": [],
                "updatedOn": "2024-01-03T09:41:12.678Z",
                "createdOn": "2024-01-03T09:41:12.678Z"
              }
            },
            {
              "quantity": 3,
              "product": {
                "_id": "65952bd21baafbb3997e37a2",
                "category": "658d4077b5b0be1aaa1031bd",
                "title": "women scarf",
                "description": "",
                "price": 600,
                "images": [],
                "updatedOn": "2024-01-03T09:41:38.992Z",
                "createdOn": "2024-01-03T09:41:38.992Z"
              }
            }
          ]
        }
        // error 
            // orderModel.toJson()
            ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.success) {
        return OrderModel.fromJson(apiResponse.data);

        // return (apiResponse.data as List<dynamic>).map((e) => CartItemModel.fromJson(e)).toList();
      }
      // if success false throwing error
      throw apiResponse.message.toString();
    } catch (ex) {
      rethrow;
    }
  }
}
