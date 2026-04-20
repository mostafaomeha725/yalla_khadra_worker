import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// ===============================
/// 🔥 INTERNAL LOADER SYSTEM
/// ===============================
class _AppLoader {
  _AppLoader._();

  static final _AppLoader instance = _AppLoader._();

  bool _isShowing = false;

  void show({
    String? message,
    bool blockUI = true,
    EasyLoadingMaskType? maskType,
  }) {
    if (_isShowing) return;

    _isShowing = true;

    EasyLoading.instance.userInteractions = !blockUI;

    EasyLoading.show(
      status: message,
      maskType:
          maskType ??
          (blockUI ? EasyLoadingMaskType.black : EasyLoadingMaskType.none),
    );
  }

  void hide() {
    if (!_isShowing) return;

    _isShowing = false;
    EasyLoading.dismiss();
  }

  void success(
    String message, {
    EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
  }) {
    _reset();
    EasyLoading.showSuccess(message, dismissOnTap: true, maskType: maskType);
  }

  void error(
    String message, {
    EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
  }) {
    _reset();
    EasyLoading.showError(message, dismissOnTap: true, maskType: maskType);
  }

  void info(
    String message, {
    EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
  }) {
    _reset();
    EasyLoading.showInfo(message, dismissOnTap: true, maskType: maskType);
  }

  void progress(double value, {String? message}) {
    EasyLoading.showProgress(value, status: message);
  }

  void _reset() {
    _isShowing = false;
    EasyLoading.dismiss();
  }
}

/// ===============================
/// 🎨 CUSTOM WAVE LOADER
/// ===============================
class WaveLoader extends StatefulWidget {
  const WaveLoader({super.key});

  @override
  State<WaveLoader> createState() => _WaveLoaderState();
}

class _WaveLoaderState extends State<WaveLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return CustomPaint(painter: _WavePainter(_controller.value));
        },
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double progress;

  _WavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    /// 🟢 الخلفية
    final bgPaint = Paint()
      ..color = const Color(0xFF1ED4B5)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, bgPaint);

    /// ⚪ الخط المتحرك (wave arc)
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final startAngle = progress * 2 * pi;
    final sweepAngle = pi / 1.8;

    final rect = Rect.fromCircle(center: center, radius: radius - 10);

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// ===============================
/// 🎨 CONFIG (CUSTOM LOADER)
/// ===============================
void configureEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1200)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 100.0
    ..radius = 24.0
    /// 🔥 مهم جدًا (يحل المشكلة)
    ..indicatorColor = Colors.transparent
    /// 🔥 CUSTOM LOADER
    ..indicatorWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: const [WaveLoader(), SizedBox(height: 16)],
    )
    ..backgroundColor = Colors.transparent
    ..textColor = Colors.white
    ..maskColor = Colors.black.withOpacity(0.4)
    ..userInteractions = false
    ..dismissOnTap = false;
}

void showLoading({
  EasyLoadingMaskType maskType = EasyLoadingMaskType.clear,
  bool userInteractions = true,
  String? status,
}) {
  _AppLoader.instance.show(
    message: status,
    blockUI: !userInteractions,
    maskType: maskType,
  );
}

void hideLoading() {
  _AppLoader.instance.hide();
}

void showError(
  String message, [
  EasyLoadingMaskType? maskType = EasyLoadingMaskType.black,
  bool dismissOnTap = true,
]) {
  _AppLoader.instance.error(
    message,
    maskType: maskType ?? EasyLoadingMaskType.black,
  );
}

void showSuccess(String message, [EasyLoadingMaskType? maskType]) {
  _AppLoader.instance.success(
    message,
    maskType: maskType ?? EasyLoadingMaskType.black,
  );
}

void showInfo(String message, [EasyLoadingMaskType? maskType]) {
  _AppLoader.instance.info(
    message,
    maskType: maskType ?? EasyLoadingMaskType.black,
  );
}

void showProgress(double value, {String? status}) {
  _AppLoader.instance.progress(value, message: status);
}
