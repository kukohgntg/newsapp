// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:newsapp/app/controllers/firebase_auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/controllers/firebase_messaging_controller.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Get.putAsync(() async => await SharedPreferences.getInstance());
  await FirebaseMessagingController().initPushNotification();
  await FirebaseMessagingController().initLocalNotification();

  runApp(Main());
}

class Main extends StatelessWidget {
  Main({super.key});
  final GetStorage _getStorage = GetStorage();
  // final _authController = Get.put(FirebaseAuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      // initialRoute: AppPages.INITIAL,
      initialRoute: _getStorage.read("userId") != null
          ? Routes.HOME
          : Routes.APPWRITE_LOGIN,
      // initialRoute: _authController.isLoggedIn.value
      //     ? Routes.HOME
      //     : Routes.FIREBASE_LOGIN,
      getPages: AppPages.routes,
    );
  }
}
