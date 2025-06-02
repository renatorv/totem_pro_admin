import 'package:get_it/get_it.dart';
import 'package:totem_pro_admin/repositories/auth_repository.dart';

final getIt = GetIt.I;

void configureDependecies() {
  getIt.registerSingleton(AuthRepository());
}
