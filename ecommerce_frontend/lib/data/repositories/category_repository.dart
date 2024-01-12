// take dta from api and convert into models like services

import 'package:dio/dio.dart';
import 'package:ecommerce_mobile_app/core/api.dart';
import 'package:ecommerce_mobile_app/data/models/category_model.dart';

class CategoryRepository {
// service from GetIt
// more like ApiHelper
  final Api _api = Api();

  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      Response response = await _api.sendRequestDio.get(
        "/category",
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.success) {
        // return apiResponse(json) to CategoryModel;

        // Iterable listJson = json.decode(apiResponse.data);
        // ApiResponse decodes it by itself

        Iterable listJson = apiResponse.data;
        List<CategoryModel> list =
            listJson.map((e) => CategoryModel.fromJson(e)).toList();

        // CategoryModel.fromJson(apiResponse.data);
        return list;

        // return (apiResponse.data as List<dynamic>).map((e) => CategoryModel.fromJson(e)).toList();
      }
      // if success false throwing error
      throw apiResponse.message.toString();
    } catch (ex) {
      rethrow;
    }
  }
}
