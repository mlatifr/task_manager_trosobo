import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_trosobo/app/routes/app_pages.dart';

class LoginController extends GetxController {
  // Global key for the form validation
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // Text editing controllers
  late TextEditingController emailController, passwordController;

  // Reactive variable for password visibility
  var isPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Login logic
  void login() {
    if (loginFormKey.currentState!.validate()) {
      // Form is valid, proceed with login
      Get.snackbar("Success", "Logging in as ${emailController.text}");
      Get.toNamed(Routes.HOME);
    }
  }
}
