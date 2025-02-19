import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String category;
  final double price;
  final int quantity;

  const ProductCard({
    super.key,
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Category: $category'),
            const SizedBox(height: 4),
            Text('Price: \$${price.toStringAsFixed(2)}'),
            const SizedBox(height: 4),
            Text('Quantity: $quantity'),
          ],
        ),
      ),
    );
  }
}