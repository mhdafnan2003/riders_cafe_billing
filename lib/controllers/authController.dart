import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:riders_cafe/Screen/Panels/branch/dashboard/dashboard.dart';
import 'package:riders_cafe/Screen/Panels/superadmin/superadmin.dart';
import 'dart:convert';

import 'package:riders_cafe/service/authservice.dart';

class AuthController extends GetxController {
  final authService = Get.find<AuthService>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/auth/login'),
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final user = data['user'];

       
        authService.login(token, user);

        if (Get.context != null) {
          Get.snackbar("Success", "Login Successful");
        }

        // Check role from user object
        if (user['role'] == 'Super Admin') {
          Get.offAll(() => Superadmin());
        } else {
          Get.offAll(() => DashboardScreen());
        }
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar('Error', errorData['message'] ?? 'Login failed');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
