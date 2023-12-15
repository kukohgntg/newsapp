// ignore_for_file: unnecessary_overrides

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/employee_model.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/appwrite_constant.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../../widgets/full_screen_dialog_loader.dart';

class CreateEmpoyeeController extends GetxController {
  AuthRepository authRepository;
  CreateEmpoyeeController(this.authRepository);

  //form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //controllers
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController departementEditingController = TextEditingController();

  //form validation
  bool isFormValid = false;

  // get storage
  final GetStorage _getStorage = GetStorage();

  var imagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();
  late String uploadedFileId;

  //
  var isEdit = false.obs;
  var imageUrl = ''.obs;
  late Employee employee;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    if (Get.arguments != null) {
      employee = Get.arguments;
      isEdit.value = true;
      nameEditingController.text = employee.name;
      departementEditingController.text = employee.departement;
      imageUrl.value =
          '${AppwriteConstants.endPoint}/storage/buckets/${AppwriteConstants.employeeBucketId}/files/${employee.image}/view?project=${AppwriteConstants.projectID}';
      // "${AppwriteConstants.endPoint}/storage/buckets/${AppwriteConstants.employeeBucketId}/files/${employee.image}/view?/project=${AppwriteConstants.projectID}";
    }
  }

  @override
  void onClose() {
    super.onClose();
    nameEditingController.dispose();
    departementEditingController.dispose();
  }

  void clearTextEditingControllers() {
    nameEditingController.clear();
    departementEditingController.clear();
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Provide Valid Name";
    }
    return null;
  }

  String? validateDepartement(String value) {
    if (value.isEmpty) {
      return "Provide Valid Departement";
    }
    return null;
  }

  void selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path;
    } else {
      CustomSnackBar.showErrorSnackBar(
          context: Get.context,
          title: "Error",
          message: "Image Sellection Cancelled");
    }
  }

  void validateAndSave(
      {required String name,
      required String departement,
      required isEdit}) async {
    isFormValid = formKey.currentState!.validate();
    if (!isFormValid) {
      return;
    } else {
      formKey.currentState!.save();
      if (!isEdit) {
        //Add
        if (imagePath.isNotEmpty) {
          try {
            FullScreenDialogLoader.showDialog();
            await authRepository
                .uploadEmployeeImage(imagePath.value)
                .then((value) async {
              uploadedFileId = value.$id;
              await authRepository.createEmploye({
                "name": name,
                "departement": departement,
                "createdBy": _getStorage.read("userId"),
                "image": uploadedFileId,
                "createdAt": DateTime.now().toIso8601String()
              }).then((value) {
                FullScreenDialogLoader.cancelDialog();
                CustomSnackBar.showSuccessSnackBar(
                    context: Get.context,
                    title: "Success",
                    message: "Data Saved");
                Get.offAllNamed(Routes.PROFILE);
              }).catchError((error) async {
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
                // await authRepository.deleteEmployeeImage(uploadedFileId);
              });
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
        } else {
          CustomSnackBar.showErrorSnackBar(
              context: Get.context,
              title: "Error",
              message: "Please selection cancelled");
        }
      } else {
        //update
        if (imagePath.isNotEmpty) {
          //user has selected new imaage
          try {
            FullScreenDialogLoader.showDialog();
            await authRepository
                .uploadEmployeeImage(imagePath.value)
                .then((value) async {
              uploadedFileId = value.$id;
              await authRepository.deleteEmployeeImage(employee.image);
              await authRepository.updateEmployee({
                "name": name,
                "departement": departement,
                "createdBy": _getStorage.read("userId"),
                "image": uploadedFileId,
                "documentId": employee.documentId,
              }).then((value) {
                FullScreenDialogLoader.cancelDialog();
                CustomSnackBar.showSuccessSnackBar(
                    context: Get.context,
                    title: "Success",
                    message: "Employee Updated");
                Get.offAllNamed(Routes.HOME);
              }).catchError((error) async {
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
                //dellete uploaded file
                await authRepository.deleteEmployeeImage(uploadedFileId);
              });
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
        } else {
          //user not selected new immge
          try {
            FullScreenDialogLoader.showDialog();
            await authRepository.updateEmployee({
              "name": name,
              "departement": departement,
              "createdBy": _getStorage.read("userId"),
              "image": employee.image,
              "documentId": employee.documentId,
            }).then((value) {
              FullScreenDialogLoader.cancelDialog();
              CustomSnackBar.showSuccessSnackBar(
                  context: Get.context,
                  title: "Success",
                  message: "Employee Updated");
              Get.offAllNamed(Routes.PROFILE);
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
    }
  }
}
