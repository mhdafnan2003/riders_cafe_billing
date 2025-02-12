import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riders_cafe/Screen/Panels/branch/addingProducts/widget/customtextfield1.dart';
import 'package:riders_cafe/controllers/productcontroller.dart';

class ProductView extends GetView<ProductController> {
  ProductView({super.key});

  @override
  final controller = ProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: Obx(() => Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: controller.formKey,
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
                      DropdownButtonFormField<String>(
                        value: controller.selectedCategory.value,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                        items: controller.categories.map((String category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: controller.changeCategory,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: controller,
                        title: 'Price',
                        controllerText: controller.priceController,
                        prefixText: '₹ ',
                        keyboardType: TextInputType.number,
                        validator: controller.validatePrice,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: controller,
                        title: 'Quantity',
                        controllerText: controller.quantityController,
                        keyboardType: TextInputType.number,
                        validator: controller.validateQuantity,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          controller.isLoading.value
                              ? 'Adding...'
                              : 'Add Product',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.isLoading.value)
                Container(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          )),
    );
  }
}



// bindings.dart

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
  }
}
