import 'package:get/get.dart';

import '../../../controllers/appwrite_controller.dart';
import '../../../data/repository/auth_repository.dart';
import '../controllers/appwrite_register_controller.dart';

class AppwriteRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppwriteRegisterController>(
      () => AppwriteRegisterController(AuthRepository(AppWriteProvider())),
    );
  }
}
