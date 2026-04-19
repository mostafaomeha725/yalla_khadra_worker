import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/routes/app_routes.dart';
import 'package:yallakhadra/core/theme/light_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Yallakhadra());
}

class Yallakhadra extends StatelessWidget {
  const Yallakhadra({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = createRouter();

    return ScreenUtilInit(
      designSize: const Size(420, 910),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Default App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppLightColors.defaultBackground,
            useMaterial3: true,
          ),
          routerConfig: router,
        );
      },
    );
  }
}
