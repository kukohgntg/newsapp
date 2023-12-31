import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/appwrite_login_controller.dart';
import '../../../widgets/my_textfield.dart';

class AppwriteLoginView extends GetView<AppwriteLoginController> {
  const AppwriteLoginView({super.key});
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
            Text(
              'welcome back, you ve been missed!',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            MyTextField(
              prefixIcon: const Icon(Icons.person),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  controller.validateAndLogin(
                    email: controller.emailEditingController.text,
                    password: controller.passwordEditingController.text,
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dont have a account?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    controller.moveToSignUp();
                  },
                  child: const Text(
                    'Register now',
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
