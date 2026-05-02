import 'package:flutter/material.dart';
import 'package:yallakhadra/core/cache/preferences_storage.dart';
import 'package:yallakhadra/core/cache/preferences_storage_keys.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/update_profile_screen_body.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void dispose() {
    final PreferencesStorage prefs = sl<PreferencesStorage>();
    UpdateProfileScreenBody.selectedProfileImagePathNotifier.value = prefs
        .getString(key: PreferencesKeys.picture);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: UpdateProfileScreenBody());
  }
}
