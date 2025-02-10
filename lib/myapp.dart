import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riders_cafe/Screen/Authentication/Login/loginscreen.dart';
import 'package:riders_cafe/Screen/Dashboard/dashboard.dart';
import 'package:riders_cafe/service/authservice.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riders Cafe',
      home: Obx(() => authService.isLoggedIn.value 
        ? DashboardScreen() 
        : LoginScreen()),
    );
  }
}