import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:math';

// ─────────────────────────────────────────
// App Loader
// ─────────────────────────────────────────

class _AppLoader {
  _AppLoader._();
  static final _AppLoader instance = _AppLoader._();
  bool _isShowing = false;

  void show({
    String? message,
    bool blockUI = true,
    EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
  }) {
    if (_isShowing) return;
    _isShowing = true;
    EasyLoading.instance.userInteractions = !blockUI;
    EasyLoading.show(
      status: message,
      maskType: maskType,
      indicator: const _MorphLoader(),
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

// ─────────────────────────────────────────
// Morph Loader (Apple style)
// ─────────────────────────────────────────

class _MorphLoader extends StatefulWidget {
  const _MorphLoader();

  @override
  State<_MorphLoader> createState() => _MorphLoaderState();
}

class _MorphLoaderState extends State<_MorphLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const int _segments = 8;
  static const double _orbitRadius = 18;
  static const double _dotMaxRadius = 3.5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
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
      width: 48,
      height: 48,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return CustomPaint(
            painter: _MorphPainter(
              progress: _controller.value,
              segments: _segments,
              orbitRadius: _orbitRadius,
              dotMaxRadius: _dotMaxRadius,
            ),
          );
        },
      ),
    );
  }
}

class _MorphPainter extends CustomPainter {
  const _MorphPainter({
    required this.progress,
    required this.segments,
    required this.orbitRadius,
    required this.dotMaxRadius,
  });

  final double progress;
  final int segments;
  final double orbitRadius;
  final double dotMaxRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double t = progress * pi * 2;

    final Paint paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < segments; i++) {
      final double angle = (i / segments) * pi * 2 + t * 1.2;
      final double phase = (t * 1.5 + i * 0.8) % (pi * 2);

      final double alpha = 0.15 + 0.85 * (0.5 + 0.5 * sin(phase));
      final double dotRadius = dotMaxRadius * (0.5 + 0.5 * sin(phase).abs());

      final double x = cx + orbitRadius * cos(angle);
      final double y = cy + orbitRadius * sin(angle);

      paint.color = Colors.white.withValues(alpha: alpha);
      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }

    // Center dot
    final double centerAlpha = 0.3 + 0.4 * sin(t * 2);
    paint.color = Colors.white.withValues(alpha: centerAlpha);
    canvas.drawCircle(Offset(cx, cy), 3, paint);
  }

  @override
  bool shouldRepaint(_MorphPainter old) => old.progress != progress;
}

// ─────────────────────────────────────────
// Config
// ─────────────────────────────────────────

void configureEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1500)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 52.0
    ..radius = 18.0
    ..backgroundColor = const Color(0xFF111111)
    ..indicatorColor = Colors.white
    ..textColor = Colors.white70
    ..maskColor = Colors.black.withValues(alpha: 0.6)
    ..userInteractions = false
    ..dismissOnTap = false;
}

// ─────────────────────────────────────────
// Public API
// ─────────────────────────────────────────

void showLoading({
  EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
  bool userInteractions = false,
  String? status,
}) {
  _AppLoader.instance.show(
    message: status,
    blockUI: !userInteractions,
    maskType: maskType,
  );
}

void hideLoading() => _AppLoader.instance.hide();

void showError(
  String message, [
  EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
]) {
  _AppLoader.instance.error(message, maskType: maskType);
}

void showSuccess(
  String message, [
  EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
]) {
  _AppLoader.instance.success(message, maskType: maskType);
}

void showInfo(
  String message, [
  EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
]) {
  _AppLoader.instance.info(message, maskType: maskType);
}

void showProgress(double value, {String? status}) {
  _AppLoader.instance.progress(value, message: status);
}
