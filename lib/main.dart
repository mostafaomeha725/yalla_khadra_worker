import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/core/routes/app_routes.dart';
import 'package:yallakhadra/core/theme/light_colors.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en', null);

  await ServiceLocator().init();
  configureEasyLoading();
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
          builder: EasyLoading.init(),
          title: 'Yalla Khadra Worker',
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
