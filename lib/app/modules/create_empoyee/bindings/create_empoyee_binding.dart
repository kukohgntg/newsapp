import 'package:get/get.dart';

import '../../../controllers/appwrite_controller.dart';
import '../../../data/repository/auth_repository.dart';
import '../controllers/create_empoyee_controller.dart';

class CreateEmpoyeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateEmpoyeeController>(
      () => CreateEmpoyeeController(AuthRepository(AppWriteProvider())),
    );
  }
}
