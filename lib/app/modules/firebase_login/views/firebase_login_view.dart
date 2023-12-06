import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/firebase_auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/firebase_login_controller.dart';
import 'my_button.dart';
import 'my_textfield.dart';


class FirebaseLoginView extends GetView<FirebaseLoginController> {
  FirebaseLoginView({super.key});
  // final LoginController _authController = Get.put(LoginController());
  final FirebaseAuthController _authController =
      Get.put(FirebaseAuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // super.dispose();
  }

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
                'Welcome back you\'ve been missed!',
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

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              // TextField(
              //   controller: _emailController,
              //   decoration: const InputDecoration(labelText: 'Email'),
              // ),
              // TextField(
              //   controller: _passwordController,
              //   obscureText: true,
              //   decoration: const InputDecoration(labelText: 'Password'),
              // ),
              // const SizedBox(height: 16),
              // Obx(() {
              //   return ElevatedButton(
              //     onPressed: _authController.isLoading.value
              //         ? null
              //         : () {
              //             _authController.loginUser(
              //               _emailController.text,
              //               _passwordController.text,
              //             );
              //           },
              //     child: _authController.isLoading.value
              //         ? const CircularProgressIndicator()
              //         : const Text('Login'),
              //   );
              // }),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: _authController.isLoading.value
                    ? null
                    : () {
                        _authController.loginUser(
                            _emailController.text, _passwordController.text);
                      },
              ),

              const SizedBox(height: 25),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account?",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.FIREBASE_REGISTER),
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
            ],
          ),
        ),
      ),
    );
  }
}
