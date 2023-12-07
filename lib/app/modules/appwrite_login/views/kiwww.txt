import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/appwrite_login_controller.dart';

class AppwriteLoginView extends GetView<AppwriteLoginController> {
  const AppwriteLoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
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
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.email),
                prefixIconColor: Colors.grey[500],
                fillColor: Colors.grey.shade200,
                filled: true,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailEditingController,
              validator: (value) {
                return controller.validateEmail(value!);
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
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.lock),
                prefixIconColor: Colors.grey[500],
                fillColor: Colors.grey.shade200,
                filled: true,
              ),
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
            // not a member? register now
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
