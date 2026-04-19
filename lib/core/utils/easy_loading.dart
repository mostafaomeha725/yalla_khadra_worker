import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yallakhadra/core/theme/light_colors.dart';

/// Configure EasyLoading with default settings
void configureEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.rotatingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppLightColors.primary
    ..backgroundColor = Colors.white
    ..indicatorColor = AppLightColors.primary
    ..textColor = Colors.black87
    ..maskColor = Colors.black.withValues(alpha: 0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..boxShadow = <BoxShadow>[];
}

void showLoading({
  EasyLoadingMaskType maskType = EasyLoadingMaskType.clear,
  bool userInteractions = true,
  String? status,
}) {
  EasyLoading.instance.userInteractions = userInteractions;
  EasyLoading.show(status: status, maskType: maskType);
}

void hideLoading() {
  EasyLoading.dismiss();
}

void showError(
  String message, [
  EasyLoadingMaskType? maskType = EasyLoadingMaskType.black,
  bool dismissOnTap = true,
]) {
  EasyLoading.dismiss();

  EasyLoading.showError(
    message,
    dismissOnTap: dismissOnTap,
    maskType: maskType ?? EasyLoadingMaskType.black,
  );
}

void showSuccess(String message, [EasyLoadingMaskType? maskType]) {
  EasyLoading.dismiss();

  EasyLoading.showSuccess(
    message,
    dismissOnTap: true,
    maskType: maskType ?? EasyLoadingMaskType.black,
  );
}

void showInfo(String message, [EasyLoadingMaskType? maskType]) {
  EasyLoading.dismiss();

  EasyLoading.showInfo(
    message,
    dismissOnTap: true,
    maskType: maskType ?? EasyLoadingMaskType.black,
  );
}

void showProgress(double value, {String? status}) {
  EasyLoading.showProgress(value, status: status);
}
