
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:riders_cafe/Screen/Dashboard/dashboard.dart';
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

        if (Get.context != null) {
          Get.snackbar("Success", "Login Successful");
        }

        authService.login(token, data['user']);
        Get.offAll(() => DashboardScreen());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
