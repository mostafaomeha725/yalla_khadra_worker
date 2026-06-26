import 'package:intl/intl.dart';

class AppDateTime {
  static String utcToLocalTime(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    final localTime = dateTime.toUtc().toLocal();
    return DateFormat("yyyy-MM-dd hh:mm a", "en").format(localTime);
  }

  static String utcToLocalDateOnly(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    final localTime = dateTime.toUtc().toLocal();
    return DateFormat("yyyy-MM-dd", "en").format(localTime);
  }

  static String timestampToFormatted(String timestamp) {
    if (timestamp.trim().isEmpty) return 'Just now';
    final DateTime? dateTime = DateTime.tryParse(timestamp);
    if (dateTime == null) return 'Just now';
    final localTime = dateTime.toUtc().toLocal();
    return DateFormat("yyyy-MM-dd hh:mm a", "en").format(localTime);
  }

  static String formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigitMinutes = '${duration.inMinutes.remainder(60)}'.padLeft(
      2,
      '0',
    );
    String twoDigitSeconds = '${duration.inSeconds.remainder(60)}'.padLeft(
      2,
      '0',
    );
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
