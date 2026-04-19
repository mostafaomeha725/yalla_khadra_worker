import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yallakhadra/core/network/network_service.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    /// Core Services
    await _initStorage();
    _initDio();

    /// Features
    // _initAuth();
    // _initHome();
  }

  /// =============================
  /// STORAGE
  /// =============================
  Future<void> _initStorage() async {
    sl.registerLazySingleton(() => SharedPreferences.getInstance());
  }

  /// =============================
  /// NETWORK
  /// =============================
  void _initDio() {
    sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => NetworkService(sl()));
  }

  /// =============================
  /// AUTH FEATURE
  /// =============================
  // void _initAuth() {
  //   sl.registerLazySingleton(() => AuthRepository(sl()));
  //   sl.registerFactory(() => LoginCubit(sl()));
  //   sl.registerFactory(() => RegisterCubit(sl()));
  // }

  // /// =============================
  // /// HOME FEATURE
  // /// =============================
  // void _initHome() {
  //   sl.registerLazySingleton(() => HomeRepository(sl()));
  //   sl.registerFactory(() => HomeCubit(sl()));
  // }
}
