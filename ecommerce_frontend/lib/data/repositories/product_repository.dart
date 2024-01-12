// take dta from api and convert into models like services

import 'package:dio/dio.dart';
import 'package:ecommerce_mobile_app/core/api.dart';
import 'package:ecommerce_mobile_app/data/models/product_model.dart';

class ProductRepository {
// service from GetIt
// more like ApiHelper
  final Api _api = Api();

  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      Response response = await _api.sendRequestDio.get("/product");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.success) {
        // return apiResponse(json) to ProductModel;

        // Iterable listJson = json.decode(apiResponse.data);
        // ApiResponse decodes it by itself

        Iterable listJson = apiResponse.data;
        List<ProductModel> list =
            listJson.map((e) => ProductModel.fromJson(e)).toList();

        // ProductModel.fromJson(apiResponse.data);
        return list;

        // return (apiResponse.data as List<dynamic>).map((e) => ProductModel.fromJson(e)).toList();
      }
      // if success false throwing error
      throw apiResponse.message.toString();
    } catch (ex) {
      rethrow;
    }
  }

 
  Future<List<ProductModel>> fetchProductsByCategory(String categoryId) async {
    try {
      Response response = await _api.sendRequestDio.get("/product/category/$categoryId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.success) {
        // return apiResponse(json) to ProductModel;

        // Iterable listJson = json.decode(apiResponse.data);
        // ApiResponse decodes it by itself

        Iterable listJson = apiResponse.data;
        List<ProductModel> list =
            listJson.map((e) => ProductModel.fromJson(e)).toList();

        // ProductModel.fromJson(apiResponse.data);
        return list;

        // return (apiResponse.data as List<dynamic>).map((e) => ProductModel.fromJson(e)).toList();
      }
      // if success false throwing error
      throw apiResponse.message.toString();
    } catch (ex) {
      rethrow;
    }
  }
}
