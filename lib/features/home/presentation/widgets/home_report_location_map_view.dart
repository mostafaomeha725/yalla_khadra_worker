import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_location_map_badge.dart';

class HomeReportLocationMapView extends StatelessWidget {
  final LatLng center;
  final double height;
  final VoidCallback onTap;

  const HomeReportLocationMapView({
    super.key,
    required this.center,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCenter: center,
                  initialZoom: 15,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.all,
                  ),
                  onTap: (tapPos, point) => onTap(),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.yallakhadra.app',
                    maxZoom: 19,
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: center,
                        width: 48.sp,
                        height: 48.sp,
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: const HomeReportLocationMapBadge(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
