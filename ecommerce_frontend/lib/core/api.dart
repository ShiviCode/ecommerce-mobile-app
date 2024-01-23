import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String baseURL = "http://192.168.1.43:3000/api";
const Map<String, dynamic> header = {"content-type": "application/json"};

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = baseURL;
    _dio.options.headers = header;
    // interceptors
    // logs response or request in debug console
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
  }
  Dio get sendRequestDio => _dio;
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;

  ApiResponse({required this.success, this.data, this.message});

  factory ApiResponse.fromResponse(Response response) {
    // new instance of the ApiResponse

    final data = response.data; // Response exists in dio

    return ApiResponse(
      success: data["success"],
      data: data["data"],
      message: data["message"] ?? "Unexpected error (message is null)",
    );
  }
}
