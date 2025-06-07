import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:totem_pro_admin/core/token_interceptor.dart';
import 'package:totem_pro_admin/models/auth_tokens.dart';
import 'package:totem_pro_admin/models/user.dart';

enum SignInError { invalidCredentials, unknown }
enum SignUpError { userAlreadyExists, unknown }

class SecureStorageKeys {
  static const refreshToken = 'refreshToken';
}

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000/admin'))
    ..interceptors.addAll([
      TokenInterceptor(),
      PrettyDioLogger(requestBody: true, requestHeader: true),
    ]);

  AuthTokens? _authTokens;
  AuthTokens? get authTokens => _authTokens;

  User? _user;
  User? get user => _user;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<bool> initialize() async {
    final refreshToken = await _secureStorage.read(key: SecureStorageKeys.refreshToken);
    if (refreshToken == null) return false;

    final result = await _refreshAccessToken(refreshToken);

    if (result.isLeft) {
      return false;
    }

    final userResult = await _getUserInfo();

    if (userResult.isLeft) {
      _authTokens = null;
      return false;
    }

    return true;
  }

  Future<Either<SignInError, void>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final response = await _dio.post(
        '/auth/login',
        data: FormData.fromMap({'username': email, 'password': password}),
      );

      _authTokens = AuthTokens.fromJson(response.data);

      await _secureStorage.write(
        key: SecureStorageKeys.refreshToken,
        value: _authTokens!.refreshToken,
      );

      final result = await _getUserInfo();

      if (result.isLeft) {
        _authTokens = null;
        return const Left(SignInError.unknown);
      }

      return const Right(null);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const Left(SignInError.invalidCredentials);
      }
      return const Left(SignInError.unknown);
    }
  }

  Future<Either<void, void>> _refreshAccessToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        '/auth/refresh',
        data: {
          'refresh_token': refreshToken,
        },
      );

      _authTokens = AuthTokens.fromJson(response.data);

      return const Right(null);
    } catch (e) {
      return const Left(null);
    }
  }

  Future<Either<void, void>> _getUserInfo() async {
    try {
      final response = await _dio.get('/users/me');
      _user = User.fromJson(response.data);
      return const Right(null);
    } catch (e) {
      return const Left(null);
    }
  }

  Future<Either<SignUpError, void>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      await _dio.post(
        '/users',
        data: {'email': email, 'name': name, 'password': password},
      );

      return const Right(null);
    } on DioException catch (e) {
      if(e.response?.statusCode == 400 && e.response?.data?['detail'] == 'User already exists') {
        return const Left(SignUpError.userAlreadyExists);
      }
      debugPrint('$e');
      return const Left(SignUpError.unknown);
    }
  }

  void signOut() {
    _authTokens = null;
    _user = null;
    _secureStorage.delete(key: SecureStorageKeys.refreshToken);
  }
}
