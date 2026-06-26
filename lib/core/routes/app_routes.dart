import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/cache/preferences_storage.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:yallakhadra/features/auth/presentation/screens/login_screen.dart';
import 'package:yallakhadra/features/auth/presentation/screens/new_password_screen.dart';
import 'package:yallakhadra/features/auth/presentation/screens/otp_screen.dart';
import 'package:yallakhadra/features/home/domain/entities/home_cleanup_task_entity.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';
import 'package:yallakhadra/features/home/presentation/screens/home_current_cleanup_screen.dart';
import 'package:yallakhadra/features/home/presentation/screens/home_report_details_screen.dart';
import 'package:yallakhadra/features/my_works/presentation/screens/my_work_completed_details_screen.dart';
import 'package:yallakhadra/features/profile/presentation/screens/change_password_screen.dart';
import 'package:yallakhadra/features/profile/presentation/screens/privacy_screen.dart';
import 'package:yallakhadra/features/profile/presentation/screens/profile_screen.dart';
import 'package:yallakhadra/features/profile/presentation/screens/update_profile_screen.dart';
import 'package:yallakhadra/core/widgets/custom_nav_bar.dart';
import 'package:yallakhadra/features/splash/presentation/screens/splash_screen.dart';
import '/core/env.dart';
import 'route_observer.dart';
import 'route_paths.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final CustomGoRouterObserver customGoRouterObserver = CustomGoRouterObserver();

bool hasAuthSession() {
  final PreferencesStorage prefs = sl<PreferencesStorage>();
  final String accessToken = (prefs.getUserToken() ?? '').trim();
  final String refreshToken = (prefs.getRefreshToken() ?? '').trim();
  return accessToken.isNotEmpty || refreshToken.isNotEmpty;
}

bool _isAuthRoute(String route) {
  return route == Routes.loginScreen ||
      route == Routes.forgetPasswordScreen ||
      route == Routes.otpScreen ||
      route == Routes.newPasswordScreen ||
      route == Routes.registerScreen ||
      route == Routes.splashScreen;
}

GoRouter createRouter() {
  return GoRouter(
    initialLocation: Routes.splashScreen,
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    redirect: (BuildContext context, GoRouterState state) {
      final bool authenticated = hasAuthSession();
      final String location = state.matchedLocation;

      if (location == Routes.splashScreen) {
        return null;
      }

      if (!authenticated && !_isAuthRoute(location)) {
        return Routes.loginScreen;
      }

      if (authenticated && location == Routes.loginScreen) {
        return Routes.mainNavigationScreen;
      }

      return null;
    },
    observers: [
      if (isDevEnviroment()) ChuckerFlutter.navigatorObserver,
      // customGoRouterObserver,
    ],
    routes: [
      GoRoute(
        path: Routes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.forgetPasswordScreen,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: Routes.otpScreen,
        builder: (context, state) {
          final String email = state.extra is String
              ? state.extra as String
              : '';
          return OtpScreen(email: email);
        },
      ),
      GoRoute(
        path: Routes.newPasswordScreen,
        builder: (context, state) {
          final Map<String, dynamic> payload =
              state.extra is Map<String, dynamic>
              ? state.extra! as Map<String, dynamic>
              : const <String, dynamic>{};
          final String email = payload['email'] as String? ?? '';
          final String code = payload['code'] as String? ?? '';
          return NewPasswordScreen(email: email, code: code);
        },
      ),
      GoRoute(
        path: Routes.profileScreen,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: Routes.profileChangePasswordScreen,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: Routes.profileUpdateProfileScreen,
        builder: (context, state) => const UpdateProfileScreen(),
      ),
      GoRoute(
        path: Routes.profilePrivacyScreen,
        builder: (context, state) => const PrivacyScreen(),
      ),
      GoRoute(
        path: Routes.mainNavigationScreen,
        builder: (context, state) => const CustomNavBar(isAdmin: false),
      ),
      GoRoute(
        path: Routes.homeReportDetailsScreen,
        builder: (context, state) {
          final HomeNearbyReportEntity report =
              state.extra is HomeNearbyReportEntity
              ? state.extra as HomeNearbyReportEntity
              : const HomeNearbyReportEntity(
                  id: 0,
                  title: 'Al Wahda Street, near City Mall',
                  distance: '0.8 km',
                  timeAgo: '2 hours ago',
                  wasteType: 'Plastic Bottles',
                  imageUrl:
                      'https://images.pexels.com/photos/3735657/pexels-photo-3735657.jpeg?auto=compress&cs=tinysrgb&w=600',
                );

          return HomeReportDetailsScreen(report: report);
        },
      ),
      GoRoute(
        path: Routes.homeCurrentCleanupScreen,
        builder: (context, state) {
          final HomeCleanupTaskEntity task =
              state.extra is HomeCleanupTaskEntity
              ? state.extra as HomeCleanupTaskEntity
              : const HomeCleanupTaskEntity(
                  title: 'Al Wahda Street, near',
                  subTitle: 'City Mall',
                  distance: '0.8 km away',
                  wasteType: 'Plastic Bottles',
                  status: 'In Progress',
                  timeAgo: 'Taken 1 hour ago',
                  imageUrl:
                      'https://images.pexels.com/photos/3735657/pexels-photo-3735657.jpeg?auto=compress&cs=tinysrgb&w=600',
                );

          return HomeCurrentCleanupScreen(task: task);
        },
      ),
      GoRoute(
        path: Routes.myWorkCompletedDetails,
        builder: (context, state) {
          final int reportId =
              state.extra is int ? state.extra as int : 0;
          return MyWorkCompletedDetailsScreen(reportId: reportId);
        },
      ),
    ],
  );
}
