import 'package:get/get.dart';

import '../../../controllers/appwrite_controller.dart';
import '../../../data/repository/auth_repository.dart';
import '../controllers/appwrite_login_controller.dart';

class AppwriteLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppwriteLoginController>(
      () => AppwriteLoginController(AuthRepository(AppWriteProvider())),
    );
  }
}
