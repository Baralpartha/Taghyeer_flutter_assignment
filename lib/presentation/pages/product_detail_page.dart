// product_detail_page.dart
import 'package:flutter/material.dart';
import '../../domain/entities/product_entity.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.thumbnail,
              height: 240,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(product.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('\$${product.price.toStringAsFixed(2)}'),
          const SizedBox(height: 16),
          Text(product.description),
        ],
      ),
    );
  }
}