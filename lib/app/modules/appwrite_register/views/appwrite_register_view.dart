import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/my_textfield.dart';
import '../controllers/appwrite_register_controller.dart';

class AppwriteRegisterView extends GetView<AppwriteRegisterController> {
  const AppwriteRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.grey[300],
      body: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(children: [
            const Icon(
              Icons.lock,
              size: 100,
            ),
            const SizedBox(height: 25),
            // welcome back, you've been missed!
            Text(
              'Create an account',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            MyTextField(
              prefixIcon: const Icon(Icons.person),
              labelText: "Name",
              keyboardType: TextInputType.name,
              obscureText: false,
              controller: controller.nameEditingController,
              validator: (value) {
                return controller.validateName(value!);
              },
            ),
            const SizedBox(height: 25),
            MyTextField(
              prefixIcon: const Icon(Icons.email),
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              controller: controller.emailEditingController,
              validator: (value) {
                return controller.validateEmail(value!);
              },
            ),
            const SizedBox(height: 25),
            MyTextField(
              prefixIcon: const Icon(Icons.lock),
              labelText: "Password",
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              controller: controller.passwordEditingController,
              validator: (value) {
                return controller.validatePassword(value!);
              },
            ),
            const SizedBox(
              height: 25,
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: context.width),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  controller.validateAndSignUp(
                      email: controller.emailEditingController.text,
                      password: controller.passwordEditingController.text,
                      name: controller.nameEditingController.text);
                },
              ),
            ),
            const SizedBox(height: 25),
            // not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Have a account?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    controller.moveToLogin();
                  },
                  child: const Text(
                    'Login now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
