// ignore_for_file: unnecessary_overrides

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/repository/auth_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../../widgets/full_screen_dialog_loader.dart';

class AppwriteLoginController extends GetxController {
  AuthRepository authRepository;
  AppwriteLoginController(this.authRepository);

  //form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //controllers
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  //form validation
  bool isFormValid = false;

  //get storage
  final GetStorage _getStorage = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
  }

  void clearTextEditingControllers() {
    passwordEditingController.clear();
    emailEditingController.clear();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide Valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Provide Valid Password";
    }
    return null;
  }

  void validateAndLogin(
      {required String email, required String password}) async {
    isFormValid = formKey.currentState!.validate();
    if (!isFormValid) {
      return;
    } else {
      formKey.currentState!.save();
      try {
        FullScreenDialogLoader.showDialog();
        await authRepository.login({
          "email": email,
          "password": password,
        }).then((value) {
          FullScreenDialogLoader.cancelDialog();
          clearTextEditingControllers();
          _getStorage.write("userId", value.userId);
          _getStorage.write("sessionId", value.$id);
          Get.offAllNamed(Routes.HOME);
        }).catchError((error) {
          FullScreenDialogLoader.cancelDialog();
          if (error is AppwriteException) {
            CustomSnackBar.showErrorSnackBar(
                context: Get.context,
                title: "Error",
                message: error.response['message']);
          } else {
            CustomSnackBar.showErrorSnackBar(
                context: Get.context,
                title: "Error",
                message: "Shomething went wrong");
          }
        });
      } catch (e) {
        FullScreenDialogLoader.cancelDialog();
        CustomSnackBar.showErrorSnackBar(
            context: Get.context,
            title: "Error",
            message: "Shomething went wrong");
      }
    }
  }

  moveToSignUp() {
    Get.toNamed(Routes.APPWRITE_REGISTER);
  }
}
