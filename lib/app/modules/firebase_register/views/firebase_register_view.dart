import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/firebase_auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/firebase_register_controller.dart';
import 'my_button.dart';
import 'my_textfield.dart';

class FirebaseRegisterView extends GetView<FirebaseRegisterController> {
  FirebaseRegisterView({super.key});
  final FirebaseAuthController _authController =
      Get.put(FirebaseAuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),

              // logo
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

              // email textfield
              MyTextField(
                controller: _emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 35),
              MyButton(
                onTap: _authController.isLoading.value
                    ? null
                    : () {
                        _authController.registerUser(
                            _emailController.text, _passwordController.text);
                      },
              ),
              // Obx(() {
              //   return ElevatedButton(
              //     onPressed: _authController.isLoading.value
              //         ? null
              //         : () {
              //             _authController.registerUser(
              //               _emailController.text,
              //               _passwordController.text,
              //             );
              //           },
              //     child: _authController.isLoading.value
              //         ? const CircularProgressIndicator()
              //         : const Text('Register'),
              //   );
              // }),

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
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.FIREBASE_LOGIN),
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
            ],
          ),
        ),
      ),
    );
  }
}
