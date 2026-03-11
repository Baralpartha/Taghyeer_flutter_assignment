import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../error/app_exception.dart';

class DioClient {
  final Dio dio;

  DioClient()
      : dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  ) {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: false));
  }

  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      return await dio.get(path, queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<Response> post(
      String path, {
        dynamic data,
        Options? options,
      }) async {
    try {
      return await dio.post(path, data: data, options: options);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  AppException _mapError(DioException e) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return NetworkException('No internet connection or request timed out.');
    }

    if (e.response != null) {
      return ServerException(
        e.response?.data?['message']?.toString() ?? 'Server error occurred.',
      );
    }

    return AppException('Unexpected network error occurred.');
  }
}