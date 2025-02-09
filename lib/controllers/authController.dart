import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;

  void login() async {
  isLoading.value = true;

  try {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/auth/login'),
      body: jsonEncode({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      
      if (Get.context != null) {  // Ensure context exists
        Get.snackbar("Success", "Login Successful");
      }
      // Navigate to Dashboard
      // Get.offNamed('/dashboard');
    } 
    
  } catch (e) {
    print("Login Error: $e");
    if (Get.context != null) {
      Get.snackbar("Error", "Something went wrong");
    }
  }

  isLoading.value = false;
}

}