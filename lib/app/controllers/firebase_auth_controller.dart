// ignore_for_file: unnecessary_overrides

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modules/firebase_login/views/firebase_login_view.dart';

class FirebaseAuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferences _prefs = Get.find<SharedPreferences>();

  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus(); // Cek status login saat controller diinisialisasi
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  Future<void> checkLoginStatus() async {
    isLoggedIn.value = _prefs.containsKey('user_token');
  }

  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.green);

      Get.off(FirebaseLoginView()); //Navigate ke Login Page
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _prefs.setString(
          'user_token', _auth.currentUser!.uid); // Simpan token autentikasi

      Get.snackbar('Success', 'Login successful',
          backgroundColor: Colors.green);

      isLoggedIn.value = true; // Set status login menjadi true

      Get.offAllNamed(
          '/home'); // Navigate ke HomePage atau ArticlePage dan hapus semua halaman sebelumnya
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    _prefs.remove('user_token'); // Hapus token autentikasi dari penyimpanan
    isLoggedIn.value = false; // Set status login menjadi false
    _auth.signOut(); // Sign out dari Firebase Authentication
    Get.offAllNamed(
        '/firebase-login'); // Navigate ke HomePage dan hapus semua halaman sebelumnya
  }
}
