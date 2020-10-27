import 'package:permission_handler/permission_handler.dart';

class Permissions {
  //Method for request permissions for Read and Write ,Camera and Audio recording
  static void requestAllPerm() async {
    await [Permission.camera, Permission.storage, Permission.microphone]
        .request();
  }

  /*Request permission for Camera returns true is already granted
  * or user just granted the permission otherwise false*/
  static Future<bool> requestCameraPerm() async =>
      await Permission.camera.request().isGranted;

  /*Request permission for Storage returns true is already granted
  * or user just granted the permission otherwise false*/
  static Future<bool> requestStoragePerm() async =>
      await Permission.storage.request().isGranted;

  /*Request permission for Microphone returns true is already granted
  * or user just granted the permission otherwise false*/
  static Future<bool> requestMicPerm() async =>
      await Permission.microphone.request().isGranted;

  /*Method to check if permissions like Read and Write ,Camera and Audio recording
  * are granted or not if granted return Future<bool>*/
  static Future<bool> isAllPermsGranted() async {
    bool cameraPerm = await Permission.camera.isGranted;
    bool storagePerm = await Permission.storage.isGranted;
    bool micPerm = await Permission.microphone.isGranted;
    if (cameraPerm && storagePerm && micPerm)
      return true;
    else
      return false;
  }

  /*The user denied access to the requested feature
  and selected to never again show a request for permissions.*/
  static Future<bool> isPermanentlyDenied() async {
    if (await Permission.camera.isPermanentlyDenied ||
        await Permission.storage.isPermanentlyDenied ||
        await Permission.microphone.isPermanentlyDenied)
      return true;
    else
      return false;
  }

  //Returns true if the app settings page could be opened, otherwise false.
  static Future<bool> openPermissionSettings() => openAppSettings();
}
