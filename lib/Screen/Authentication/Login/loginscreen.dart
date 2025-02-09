import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riders_cafe/common/customtextfield.dart';
import 'package:riders_cafe/controllers/authController.dart';


class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('Assets/Images/Authentication/logo.png', height: 100), // Company logo
              SizedBox(height: 20),
              CustomTextField(
                controller: authController.emailController,
                label: "Email",
                icon: Icons.email,
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: authController.passwordController,
                label: "Password",
                icon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 20),
              Obx(() => authController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => authController.login(),
                      child: Text("Login"),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}