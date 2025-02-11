import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riders_cafe/Screen/Authentication/Login/loginscreen.dart';
import 'package:riders_cafe/service/authservice.dart';

class Superadmin extends StatelessWidget {
  const Superadmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.find<AuthService>().logout();
            Get.snackbar('Success', 'Logout Successful');
            Get.offAll(() => LoginScreen());
          },
          child: Icon(Icons.logout)),
          body: Center(
          child: Text('Super Admin ${Get.find<AuthService>().getUser()?['name']}'),
      ),
    );
  }
}