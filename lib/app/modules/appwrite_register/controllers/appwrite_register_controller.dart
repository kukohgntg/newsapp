// ignore_for_file: unnecessary_overrides

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/auth_repository.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../../widgets/full_screen_dialog_loader.dart';

class AppwriteRegisterController extends GetxController {
  AuthRepository authRepository;
  AppwriteRegisterController(this.authRepository);

  //form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //controllers
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();

  //form validation
  bool isFormValid = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
    nameEditingController.dispose();
  }

  void clearTextEditingControllers() {
    passwordEditingController.clear();
    emailEditingController.clear();
    nameEditingController.clear();
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

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Provide Valid Name";
    }
    return null;
  }

  void validateAndSignUp({
    required String email,
    required String password,
    required String name,
  }) async {
    isFormValid = formKey.currentState!.validate();
    if (!isFormValid) {
      return;
    } else {
      formKey.currentState!.save();
      try {
        FullScreenDialogLoader.showDialog();
        await authRepository.signup({
          "userId": ID.unique(),
          "name": name,
          "email": email,
          "password": password,
        }).then((value) {
          FullScreenDialogLoader.cancelDialog();
          CustomSnackBar.showSuccessSnackBar(
              context: Get.context,
              title: "Success",
              message: "User account created");
          clearTextEditingControllers();
          // Get.offAllNamed(Routes.LOGIN);
          // Get.back();
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

  moveToLogin() {
    Get.back();
  }
}
