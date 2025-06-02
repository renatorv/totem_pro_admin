import 'package:dio/dio.dart';
import 'package:totem_pro_admin/core/di.dart';

import '../repositories/auth_repository.dart';

class TokenInterceptor extends Interceptor {
  // aula 9 - 58 minutos
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final AuthRepository authRepository = getIt();
    final token = authRepository.authTokens?.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
