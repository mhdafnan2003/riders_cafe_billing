import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riders_cafe/utils/colors.dart';

class ProductController extends GetxController {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  final selectedCategory = 'Full Face Helmets'.obs;
  final isLoading = false.obs;

  final categories = [
    'Full Face Helmets',
    'Half Face Helmets',
    'Offroad Helmets',
    'Accessories'
  ];

  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.onClose();
  }

  void changeCategory(String? value) {
    if (value != null) {
      selectedCategory.value = value;
    }
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        final product = {
          'name': nameController.text,
          'description': descriptionController.text,
          'category': selectedCategory.value,
          'price': double.parse(priceController.text),
          'quantity': int.parse(quantityController.text),
        };

        try {
          var response = await http.post(
            Uri.parse('http://localhost:3000/api/dashboard/addproducts'),
            body: jsonEncode(product),
            headers: {"Content-Type": "application/json"},
          );

          if (kDebugMode) {
            print('Response status code: ${response.statusCode}');
          }
          if (kDebugMode) {
            print('Response body: ${response.body}');
          }
          if (response.statusCode == 201) {
          Get.snackbar(
          'Success',
          'Product added successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TColor.primary,
          colorText: Colors.white,
        );
        }
        } catch (e) {
          if (kDebugMode) {
            print('Error parsing response: $e');
          }
        }
        

        

        // Clear form
        clearForm();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to add product: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  void clearForm() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    quantityController.clear();
    selectedCategory.value = categories[0];
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter product name';
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter price';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter quantity';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }
}
