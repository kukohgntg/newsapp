import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:newsapp/app/controllers/firebase_auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() async => await SharedPreferences.getInstance());

  runApp(Main());
}

class Main extends StatelessWidget {
  Main({super.key});
  final _authController = Get.put(FirebaseAuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      // initialRoute: AppPages.INITIAL,
      initialRoute: _authController.isLoggedIn.value
          ? Routes.HOME
          : Routes.FIREBASE_LOGIN,
      getPages: AppPages.routes,
    );
  }
}
