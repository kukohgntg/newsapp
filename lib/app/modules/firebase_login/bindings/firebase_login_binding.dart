import 'package:get/get.dart';

import '../controllers/firebase_login_controller.dart';

class FirebaseLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseLoginController>(
      () => FirebaseLoginController(),
    );
  }
}
