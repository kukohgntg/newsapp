import 'package:get/get.dart';

import '../../../controllers/appwrite_controller.dart';
import '../../../data/repository/auth_repository.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileController>(
      ProfileController(AuthRepository(AppWriteProvider())),
    );
  }
}
