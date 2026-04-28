import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yallakhadra/core/routes/app_routes.dart';
import 'package:yallakhadra/core/routes/route_paths.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart';
import 'package:yallakhadra/core/utils/validators.dart';
import 'package:yallakhadra/core/widgets/custom_loading.dart';

class Helpers {
  static String formatTakenTimeAgo(String dateTimeString) {
    final DateTime? parsed = DateTime.tryParse(dateTimeString);
    if (parsed == null) {
      return 'Taken recently';
    }

    final Duration diff = DateTime.now().difference(parsed.toLocal());
    if (diff.inMinutes < 1) {
      return 'Taken just now';
    }
    if (diff.inMinutes < 60) {
      final int m = diff.inMinutes;
      return 'Taken $m ${m == 1 ? 'minute' : 'minutes'} ago';
    }
    if (diff.inHours < 24) {
      final int h = diff.inHours;
      return 'Taken $h ${h == 1 ? 'hour' : 'hours'} ago';
    }
    final int d = diff.inDays;
    return 'Taken $d ${d == 1 ? 'day' : 'days'} ago';
  }

  static Future<String> formatDistanceFromCurrentLocation({
    required double targetLatitude,
    required double targetLongitude,
  }) async {
    if (targetLatitude == 0 && targetLongitude == 0) {
      return 'Distance unavailable';
    }

    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Location is off';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return 'Location permission required';
    }

    final Position position = await Geolocator.getCurrentPosition();
    final double meters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      targetLatitude,
      targetLongitude,
    );

    if (meters < 1000) {
      return '${meters.round()} m away';
    }

    final double km = meters / 1000;
    return '${km.toStringAsFixed(1)} km away';
  }

  static String formatMyWorkCompletedAt(String completedAt) {
    final DateTime? dateTime = DateTime.tryParse(completedAt);
    if (dateTime == null) {
      return completedAt;
    }

    final DateTime now = DateTime.now();
    final DateTime localDateTime = dateTime.toLocal();
    final Duration difference = now.difference(localDateTime);

    final String hour = (dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12)
        .toString()
        .padLeft(2, '0');
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    final String period = dateTime.hour >= 12 ? 'PM' : 'AM';
    final String timeText = '$hour:$minute $period';

    if (difference.inDays <= 0) {
      return 'Today, $timeText';
    }

    if (difference.inDays < 30) {
      return '${difference.inDays} days ago, $timeText';
    }

    final int months = (difference.inDays / 30).floor();
    if (months < 12) {
      return '${months == 1 ? '1 month' : '$months months'} ago, $timeText';
    }

    final int years = (months / 12).floor();
    return '${years == 1 ? '1 year' : '$years years'} ago, $timeText';
  }

  static String formatMyWorkDuration(String duration) {
    final int firstDotIndex = duration.indexOf('.');
    if (firstDotIndex <= 0 || firstDotIndex == duration.length - 1) {
      return duration;
    }

    final String daysPart = duration.substring(0, firstDotIndex);
    final String timePart = duration.substring(firstDotIndex + 1);

    final int days = int.tryParse(daysPart) ?? 0;
    final List<String> timeParts = timePart.split(':');
    if (timeParts.length < 2) {
      return duration;
    }

    final int hours = int.tryParse(timeParts[0]) ?? 0;
    final int minutes = int.tryParse(timeParts[1]) ?? 0;
    final int totalHours = (days * 24) + hours;

    return '${totalHours}h ${minutes.toString().padLeft(2, '0')}m';
  }

  static void handleResetPassword({
    required BuildContext context,
    required String email,
  }) {
    final String? validationError = Validators.validateForgotPasswordEmail(
      email,
    );

    if (validationError != null) {
      showError(validationError);
      return;
    }

    showSuccess('A new verification code has been sent.');

    context.push(Routes.otpScreen);
  }

  static void handleBackToLogin(BuildContext context) {
    context.go(Routes.loginScreen);
  }

  static void handleVerifyOtp({
    required BuildContext context,
    required String otpCode,
  }) {
    final String? validationError = Validators.validateOtpCode(otpCode);

    if (validationError != null) {
      showError(validationError);
      return;
    }

    showSuccess('Code verified successfully.');

    context.push(Routes.newPasswordScreen);
  }

  static void handleResendOtp(BuildContext context) {
    showSuccess('A new verification code has been sent.');
  }

  static void handleChangePassword({
    required BuildContext context,
    required String newPassword,
    required String confirmPassword,
  }) {
    final String? validationError = Validators.validateNewPasswordCredentials(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    if (validationError != null) {
      showError(validationError);
      return;
    }

    showSuccess('Password changed successfully.');

    context.go(Routes.loginScreen);
  }

  static void handleProfileChangePassword({
    required BuildContext context,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    final String? validationError =
        Validators.validateProfileChangePasswordCredentials(
          currentPassword: currentPassword,
          newPassword: newPassword,
          confirmPassword: confirmPassword,
        );

    if (validationError != null) {
      showError(validationError);
      return;
    }

    showSuccess('Password changed successfully.');
  }

  static Future<void> handleProfileAvatarTap(BuildContext context) async {
    final File? pickedImage = await pickImage();

    if (pickedImage == null) {
      showError('No image selected.');
      return;
    }

    showSuccess('Image selected successfully.');
  }

  static void handleUpdateProfileSave({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) {
    final String? validationError = Validators.validateProfileUpdateData(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );

    if (validationError != null) {
      showError(validationError);
      return;
    }

    showSuccess('Profile updated successfully.');
  }

  static void handleOpenUpdateProfile(BuildContext context) {
    context.push(Routes.profileUpdateProfileScreen);
  }

  static void handleOpenChangePassword(BuildContext context) {
    context.push(Routes.profileChangePasswordScreen);
  }

  static void handleOpenPrivacyTerms(BuildContext context) {
    context.push(Routes.profilePrivacyScreen);
  }

  static void handleProfileLogout(BuildContext context) {
    showSuccess('Logged out successfully.');
    context.go(Routes.loginScreen);
  }

  static Future<void> handleOpenGoogleMapsSearch(String query) async {
    final bool opened = await LauncherHelper.launchGoogleMapsSearch(
      query: query,
    );
    if (!opened) {
      showError('Could not open Google Maps.');
    }
  }

  static Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      return imageFile;
    }
    return null;
  }

  static Future<File?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    return File(image.path);
  }

  static Future<File?> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    }
    return File(image.path);
  }

  static Future<List<File>> getImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> result = await picker.pickMultiImage();
    if (result.isNotEmpty) {
      List<File> files = result.map((e) => File(e.path)).toList();
      return files;
    } else {
      return [];
    }
  }

  static Future<File?> getImageFromCameraOrDevice() async {
    final ImagePicker picker = ImagePicker();
    File? image;

    await showCupertinoModalPopup(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Select Image Source'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  image = File(pickedFile.path);
                }
                Navigator.of(context).pop();
              },
              child: const Text('gallery'),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                final pickedFile = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (pickedFile != null) {
                  image = File(pickedFile.path);
                }
                Navigator.of(context).pop();
              },
              child: const Text('camera'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        );
      },
    );

    return image;
  }

  static Future<List<File>> pickLimitedImagesWithMaxSize({
    required int maxCount,
    int maxSizeInMB = 5,
  }) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> result = await picker.pickMultiImage();

    if (result.isEmpty) return [];

    List<File> validFiles = [];

    for (final xfile in result) {
      if (validFiles.length >= maxCount) break;

      final file = File(xfile.path);
      final bytes = await file.length();

      final sizeInMB = bytes / (1024 * 1024);

      if (sizeInMB <= maxSizeInMB) {
        validFiles.add(file);
      }
    }

    return validFiles;
  }

  static void shareApp(String url) {
    CustomLoading.showLoader();
    SharePlus.instance.share(ShareParams(uri: Uri.parse(url)));
  }

  static Future<File?> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  static void showPdfPreview(BuildContext context, File onValue) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoPopupSurface(
          blurSigma: 1.0,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              width: double.infinity, // Width of the PDF viewer popup
              height: 380, // Height of the PDF viewer popup
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  // PDF viewer in the center
                  // SfPdfViewer.file(onValue),

                  // Close Button at the top right
                  CupertinoButton(
                    padding: const EdgeInsets.all(5),
                    child: const Icon(CupertinoIcons.clear),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LauncherHelper {
  static void launchURL({required String url}) async {
    if (!url.toString().startsWith("https")) {
      url = "https://$url";
    }
    await launchUrl(Uri.parse(url));
  }

  static void launchWhatsApp(String phone) async {
    String message = 'مرحبا بك';
    if (phone.startsWith("00966")) {
      phone = phone.substring(5);
    }
    var whatsAppUrl = "whatsapp://send?phone=+966$phone&text=$message";
    debugPrint(whatsAppUrl);
    if (await canLaunchUrl(Uri.parse(whatsAppUrl))) {
      await launchUrl(Uri.parse(whatsAppUrl));
    } else {
      throw 'AppStrings.error.tr()';
    }
  }

  static void launchYoutube({required String url}) async {
    final Uri parsedUrl = Uri.parse(url);
    if (Platform.isIOS) {
      if (await canLaunchUrl(parsedUrl)) {
        await launchUrl(parsedUrl);
      } else {
        if (await canLaunchUrl(parsedUrl)) {
          await launchUrl(parsedUrl);
        } else {
          throw 'Could not launch $parsedUrl';
        }
      }
    } else {
      if (await canLaunchUrl(parsedUrl)) {
        await launchUrl(parsedUrl);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  static Future<void> launchTwitter(String userName) async {
    final twitterProfileUrl = Uri.parse(
      'twitter://user?screen_name=$userName',
    ); // Twitter app URL
    final Uri webUrl = Uri.parse('https://twitter.com/$userName'); // Web URL
    try {
      if (await canLaunchUrl(twitterProfileUrl)) {
        await launchUrl(twitterProfileUrl);
      } else {
        if (await canLaunchUrl(webUrl)) {
          await launchUrl(webUrl);
        } else {
          throw 'Could not launch Twitter in a web browser';
        }
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static Future<void> launchInstagram(String userName) async {
    final Uri instagramProfileUrl = Uri.parse(
      'https://www.instagram.com/$userName',
    ); // Replace with your Instagram profile URL
    final Uri instagramNativeApp = Uri.parse(
      'instagram://user?username=$userName',
    );

    try {
      if (await canLaunchUrl(instagramNativeApp)) {
        await launchUrl(instagramNativeApp); // Open Instagram app
      } else {
        if (await canLaunchUrl(instagramProfileUrl)) {
          await launchUrl(instagramProfileUrl);
        } else {
          throw 'Could not launch Instagram in a web browser';
        }
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  void launchFacebook(String userName) async {
    final Uri nativeUrl = Uri.parse(
      'fb://facewebmodal/f?href=https://www.facebook.com/$userName',
    );
    final Uri webUrl = Uri.parse('https://www.facebook.com/$userName');
    if (await canLaunchUrl(nativeUrl)) {
      await launchUrl(nativeUrl);
    } else {
      if (await canLaunchUrl(webUrl)) {
        await launchUrl(webUrl);
      } else {
        throw 'Could not launch $webUrl';
      }
    }
  }

  static Future<void> launchSnapchat(String userName) async {
    final snapchatProfileUrl = Uri.parse(
      'https://www.snapchat.com/add/$userName',
    );
    final snapChatNativeApp = Uri.parse('snapchat://add/$userName');

    try {
      if (await canLaunchUrl(snapChatNativeApp)) {
        await launchUrl(snapChatNativeApp);
      } else {
        if (await canLaunchUrl(snapchatProfileUrl)) {
          await launchUrl(snapchatProfileUrl);
        } else {
          throw 'Could not launch Snapchat in a web browser';
        }
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static Future<void> launchTikTok(String userName) async {
    final tiktokProfileUrl = Uri.parse('https://www.tiktok.com/@$userName');

    try {
      if (await canLaunchUrl(Uri.parse('com.zhiliaoapp.musically'))) {
        await launchUrl(
          Uri.parse('com.zhiliaoapp.musically://user?u=$userName'),
        );
      } else {
        if (await canLaunchUrl(tiktokProfileUrl)) {
          await launchUrl(tiktokProfileUrl);
        } else {
          throw 'Could not launch TikTok in a web browser';
        }
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static void callPhone({phone}) async {
    await launchUrl(Uri.parse('tel:$phone'));
  }

  static void sendMail(mail) async {
    await launchUrl(Uri.parse('mailto:$mail'));
  }

  static Future<bool> launchGoogleMapsSearch({required String query}) async {
    final String trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) return false;

    final String encodedQuery = Uri.encodeComponent(trimmedQuery);

    final List<Uri> candidates = Platform.isIOS
        ? <Uri>[
            Uri.parse('comgooglemaps://?q=$encodedQuery'),
            Uri.parse('https://maps.apple.com/?q=$encodedQuery'),
            Uri.parse(
              'https://www.google.com/maps/search/?api=1&query=$encodedQuery',
            ),
          ]
        : <Uri>[
            Uri.parse('geo:0,0?q=$encodedQuery'),
            Uri.parse(
              'https://www.google.com/maps/search/?api=1&query=$encodedQuery',
            ),
          ];

    for (final Uri uri in candidates) {
      try {
        final bool launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (launched) {
          return true;
        }

        if ((uri.scheme == 'https' || uri.scheme == 'http')) {
          final bool launchedWithDefault = await launchUrl(
            uri,
            mode: LaunchMode.platformDefault,
          );
          if (launchedWithDefault) {
            return true;
          }
        }
      } catch (e) {
        log('Maps launch failed for $uri: $e');
      }
    }

    return false;
  }
}
