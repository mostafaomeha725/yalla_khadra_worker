import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/features/reports/domain/usecases/get_nearby_reports_use_case.dart';
import 'package:yallakhadra/features/reports/presentation/cubit/reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final GetNearbyReportsUseCase _getNearbyReportsUseCase;
  final bool useRadiusByDefault;
  double? latitude;
  double? longitude;

  ReportsCubit(this._getNearbyReportsUseCase, {this.useRadiusByDefault = true})
    : super(const ReportsInitial());
  static const int _pageSize = 10;

  int _currentPage = 1;
  double? _radiusInKm;

  Future<void> loadReports({int pageNumber = 1, double? radiusInKm}) async {
    emit(const ReportsLoading());

    try {
      if (latitude == null || longitude == null) {
        final position = await Helpers.getUserLocation();
        if (position != null) {
          latitude = position.latitude;
          longitude = position.longitude;
        }
      }

      _radiusInKm = radiusInKm;
      final page = await _getNearbyReportsUseCase(
        GetNearbyReportsParams(
          latitude: latitude,
          longitude: longitude,
          radiusInKm: useRadiusByDefault ? _radiusInKm : null,
          pageNumber: pageNumber,
          pageSize: _pageSize,
        ),
      );
      _currentPage = page.currentPage;
      emit(ReportsLoaded(page: page, radiusInKm: _radiusInKm));
    } catch (error) {
      emit(ReportsError(error.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> applyRadius(String value) async {
    final String trimmed = value.trim();
    if (!useRadiusByDefault) {
      await loadReports(pageNumber: 1, radiusInKm: null);
      return;
    }

    final double? parsed = trimmed.isEmpty ? null : double.tryParse(trimmed);

    if (trimmed.isNotEmpty && parsed == null) {
      emit(const ReportsError('Please enter a valid number for radius.'));
      return;
    }

    if (parsed != null && parsed > 100) {
      emit(const ReportsError('Radius must not exceed 100 km.'));
      return;
    }

    await loadReports(pageNumber: 1, radiusInKm: parsed);
  }

  Future<void> refreshReports() async {
    await loadReports(pageNumber: _currentPage, radiusInKm: _radiusInKm);
  }

  Future<void> loadNextPage() async {
    final ReportsState current = state;
    if (current is! ReportsLoaded || !current.page.hasNextPage) {
      return;
    }
    await loadReports(pageNumber: _currentPage + 1, radiusInKm: _radiusInKm);
  }

  Future<void> loadPreviousPage() async {
    final ReportsState current = state;
    if (current is! ReportsLoaded || !current.page.hasPreviousPage) {
      return;
    }
    await loadReports(pageNumber: _currentPage - 1, radiusInKm: _radiusInKm);
  }
}
