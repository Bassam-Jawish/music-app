import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Requests audio and storage permissions for the app.
Future<void> requestSongPermission() async {

  try {
    // Check if audio permissions are already granted
    final bool audioGranted = await Permission.audio.isGranted;

    // If permissions are not granted, request them
    if (!audioGranted) {
      final Map<Permission, PermissionStatus> statuses = await [
        Permission.audio,
      ].request();

      // If permissions are permanently denied, open app settings
      if (statuses[Permission.audio] == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }
    }
  } catch (e) {
    // Handle any errors that occur during the process
    debugPrint('Error requesting song permissions: $e');
  }
}
