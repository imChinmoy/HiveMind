import 'package:dio/dio.dart';
import 'package:frontend/config/constants/app_constants.dart';
import 'package:frontend/features/auth/data/api/local_datasource.dart';

class NetworkService {
  late final Dio _dio;
  final LocalDatasource localDatasource;

  NetworkService({required this.localDatasource}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.apiDevelopmentUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _initializeInterceptors();
  }

  Dio get dio => _dio;

  void _initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await localDatasource.getAccessToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }
}
