import 'package:flutter/material.dart';
import 'package:yallakhadra/core/constants/app_assets.dart';

class AppAsset extends StatelessWidget {
  const AppAsset({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    this.color,
    this.fit,
  });

  final String assetName;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    String assetPath = assetName;
    if (!assetPath.contains('assets')) {
      assetPath = Assets.logo;
    }
    return Image.asset(
      assetPath,
      height: height,
      width: width,
      color: color,
      fit: fit,
    );
  }
}
