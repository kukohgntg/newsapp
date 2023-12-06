import 'package:get/get.dart';

import '../controllers/firebase_register_controller.dart';

class FirebaseRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseRegisterController>(
      () => FirebaseRegisterController(),
    );
  }
}
