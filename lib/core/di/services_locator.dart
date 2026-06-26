import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yallakhadra/core/cache/preferences_storage.dart';
import 'package:yallakhadra/core/network/network_service.dart';
import 'package:yallakhadra/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:yallakhadra/features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:yallakhadra/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:yallakhadra/features/auth/domain/repositories/auth_repository.dart';
import 'package:yallakhadra/features/auth/domain/usecases/auth_usecase.dart';
import 'package:yallakhadra/features/auth/domain/usecases/confirm_password_reset_usecase.dart';
import 'package:yallakhadra/features/auth/domain/usecases/request_password_reset_usecase.dart';
import 'package:yallakhadra/features/auth/domain/usecases/verify_password_reset_code_usecase.dart';
import 'package:yallakhadra/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:yallakhadra/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:yallakhadra/features/my_works/data/data_sources/my_works_remote_data_source.dart';
import 'package:yallakhadra/features/my_works/data/data_sources/my_works_remote_data_source_impl.dart';
import 'package:yallakhadra/features/my_works/data/repositories/my_works_repository_impl.dart';
import 'package:yallakhadra/features/my_works/domain/repositories/my_works_repository.dart';
import 'package:yallakhadra/features/my_works/domain/usecases/get_completed_work_details_use_case.dart';
import 'package:yallakhadra/features/my_works/domain/usecases/get_my_work_overview_use_case.dart';
import 'package:yallakhadra/features/my_works/domain/usecases/get_my_work_reports_use_case.dart';
import 'package:yallakhadra/features/my_works/presentation/cubit/my_work_details/my_work_details_cubit.dart';
import 'package:yallakhadra/features/my_works/presentation/cubit/my_work_overview/my_work_overview_cubit.dart';
import 'package:yallakhadra/features/ai_scan/data/data_sources/ai_scan_remote_data_source.dart';
import 'package:yallakhadra/features/ai_scan/data/data_sources/ai_scan_remote_data_source_impl.dart';
import 'package:yallakhadra/features/ai_scan/data/repositories/ai_scan_repository_impl.dart';
import 'package:yallakhadra/features/ai_scan/domain/repositories/ai_scan_repository.dart';
import 'package:yallakhadra/features/ai_scan/domain/usecases/get_my_waste_scans_usecase.dart';
import 'package:yallakhadra/features/ai_scan/domain/usecases/scan_waste_image_usecase.dart';
import 'package:yallakhadra/features/ai_scan/presentation/cubit/ai_scan/ai_scan_cubit.dart';
import 'package:yallakhadra/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:yallakhadra/features/profile/data/data_sources/profile_remote_data_source_impl.dart';
import 'package:yallakhadra/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:yallakhadra/features/profile/domain/repositories/profile_repository.dart';
import 'package:yallakhadra/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:yallakhadra/features/profile/domain/usecases/logout_usecase.dart';
import 'package:yallakhadra/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/change_password_cubit.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/profile_logout_cubit.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/update_profile_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    /// Core Services
    await _initStorage();
    _initDio();

    /// Features
    _initAuth();
    _initAiScan();
    _initProfile();
    _initMyWorks();
    // _initHome();
  }

  /// =============================
  /// STORAGE
  /// =============================
  Future<void> _initStorage() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
    sl.registerLazySingleton<PreferencesStorage>(
      () => PreferencesStorage(sl()),
    );
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
  void _initAuth() {
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()),
    );
    sl.registerLazySingleton(() => AuthUseCase(sl()));
    sl.registerLazySingleton(() => ConfirmPasswordResetUseCase(sl()));
    sl.registerLazySingleton(() => RequestPasswordResetUseCase(sl()));
    sl.registerLazySingleton(() => VerifyPasswordResetCodeUseCase(sl()));
    sl.registerFactory(() => LoginCubit(sl()));
    sl.registerFactory(() => ForgotPasswordCubit(sl(), sl(), sl()));
  }

  /// =============================
  /// AI SCAN FEATURE
  /// =============================
  void _initAiScan() {
    sl.registerLazySingleton<AiScanRemoteDataSource>(
      () => AiScanRemoteDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<AiScanRepository>(
      () => AiScanRepositoryImpl(sl()),
    );
    sl.registerLazySingleton(() => GetMyWasteScansUseCase(sl()));
    sl.registerLazySingleton(() => ScanWasteImageUseCase(sl()));
    sl.registerFactory(() => AiScanCubit(sl(), sl()));
  }

  /// =============================
  /// PROFILE FEATURE
  /// =============================
  void _initProfile() {
    sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl(), sl()),
    );
    sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
    sl.registerLazySingleton(() => LogoutUseCase(sl()));
    sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
    sl.registerFactory(() => ChangePasswordCubit(sl()));
    sl.registerFactory(() => ProfileLogoutCubit(sl()));
    sl.registerFactory(() => UpdateProfileCubit(sl()));
  }

  /// =============================
  /// MY WORKS FEATURE
  /// =============================
  void _initMyWorks() {
    sl.registerLazySingleton<MyWorksRemoteDataSource>(
      () => MyWorksRemoteDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<MyWorksRepository>(
      () => MyWorksRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerLazySingleton(() => GetMyWorkOverviewUseCase(sl()));
    sl.registerLazySingleton(() => GetMyWorkReportsUseCase(sl()));
    sl.registerLazySingleton(() => GetCompletedWorkDetailsUseCase(sl()));
    sl.registerFactory(
      () => MyWorkOverviewCubit(
        sl<GetMyWorkOverviewUseCase>(),
        sl<GetMyWorkReportsUseCase>(),
      ),
    );
    sl.registerFactory(
      () => MyWorkDetailsCubit(sl<GetCompletedWorkDetailsUseCase>()),
    );
  }

  // /// =============================
  // /// HOME FEATURE
  // /// =============================
  // void _initHome() {
  //   sl.registerLazySingleton(() => HomeRepository(sl()));
  //   sl.registerFactory(() => HomeCubit(sl()));
  // }
}
