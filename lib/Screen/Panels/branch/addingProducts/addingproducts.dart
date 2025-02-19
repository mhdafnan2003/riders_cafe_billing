import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riders_cafe/Screen/Panels/branch/addingProducts/widget/customtextfield1.dart';
import 'package:riders_cafe/controllers/productcontroller.dart';
import 'package:riders_cafe/utils/colors.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: TColor.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  controller: controller,
                  title: 'Product Name',
                  controllerText: controller.nameController,
                  validator: controller.validateName,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: controller,
                  title: 'Description',
                  controllerText: controller.descriptionController,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                // Category Dropdown
                Obx(() => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  value: controller.selectedCategory.value,
                  items: controller.categories.map((String category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: controller.changeCategory,
                )),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: controller,
                  title: 'Price',
                  controllerText: controller.priceController,
                  validator: controller.validatePrice,
                  keyboardType: TextInputType.number,
                  prefixText: '\$',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: controller,
                  title: 'Quantity',
                  controllerText: controller.quantityController,
                  validator: controller.validateQuantity,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColor.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Add Product',
                          style: TextStyle(fontSize: 16),
                        ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}