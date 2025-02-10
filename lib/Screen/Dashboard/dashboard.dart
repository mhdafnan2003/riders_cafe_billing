import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riders_cafe/Screen/Authentication/Login/loginscreen.dart';
import 'package:riders_cafe/service/authservice.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => Get.offAll(() => LoginScreen()),
          child: Icon(Icons.logout)),
      body: Center(
        child: Text('Welcome ${Get.find<AuthService>().getUser()?['name']}'),
      ),
    );
  }
}
