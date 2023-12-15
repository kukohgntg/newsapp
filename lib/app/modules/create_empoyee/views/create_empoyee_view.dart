import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_empoyee_controller.dart';

class CreateEmpoyeeView extends GetView<CreateEmpoyeeController> {
  const CreateEmpoyeeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(children: [
              Stack(
                children: [
                  Obx(() => !controller.isEdit.value
                      ? (controller.imagePath.value == ''
                          ? const CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                            )
                          : CircleAvatar(
                              radius: 80,
                              backgroundImage: FileImage(
                                File(controller.imagePath.value),
                              ),
                            ))
                      : (controller.imagePath.value != ''
                          ? CircleAvatar(
                              radius: 80,
                              backgroundImage: FileImage(
                                File(controller.imagePath.value),
                              ),
                            )
                          :
                          // Container(
                          //     width: 160,
                          //     height: 160,
                          //     decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       image: DecorationImage(
                          //         image: CachedNetworkImageProvider(
                          //             controller.imageUrl.value),
                          //       ),
                          //     ),
                          //   )
                          CircleAvatar(
                              radius: 80,
                              backgroundImage: CachedNetworkImageProvider(
                                controller.imageUrl.value,
                              ),
                              // child: CachedNetworkImage(
                              //   imageUrl: controller.imageUrl.value,
                              //   width: 100,
                              //   height: 100,
                              // ),
                            ))),
                  Positioned(
                    bottom: 1,
                    left: 100,
                    child: FloatingActionButton(
                      child: const Icon(Icons.add_a_photo),
                      onPressed: () {
                        controller.selectImage();
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: Colors.grey[500],
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
                keyboardType: TextInputType.text,
                controller: controller.nameEditingController,
                validator: (value) {
                  return controller.validateName(value!);
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  labelText: "Departement",
                  labelStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: const Icon(Icons.abc),
                  prefixIconColor: Colors.grey[500],
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
                keyboardType: TextInputType.text,
                controller: controller.departementEditingController,
                validator: (value) {
                  return controller.validateDepartement(value!);
                },
              ),
              const SizedBox(height: 25),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Obx(
              //       () => controller.imagePath.value == ''
              //           ? const Text(
              //               'Select image from Gallery',
              //               style: TextStyle(fontSize: 20),
              //             )
              //           : CircleAvatar(
              //               radius: 80,
              //               backgroundImage: FileImage(
              //                 File(controller.imagePath.value),
              //               ),
              //             ),
              //     ),
              //     IconButton(
              //       icon: const Icon(Icons.image),
              //       onPressed: () {
              //         controller.selectImage();
              //       },
              //     )
              //   ],
              // ),
              // const SizedBox(height: 20),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: context.width),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(14)),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    controller.validateAndSave(
                        name: controller.nameEditingController.text,
                        departement:
                            controller.departementEditingController.text,
                        isEdit: controller.isEdit.value);
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
