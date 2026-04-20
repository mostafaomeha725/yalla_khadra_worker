import 'package:flutter/material.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart' as app_loading;

class CustomSnackBar {
  static void showSuccess(BuildContext context, {required String message}) {
    app_loading.showSuccess(message);
  }

  static void showError(BuildContext context, {required String message}) {
    app_loading.showError(message);
  }
}
