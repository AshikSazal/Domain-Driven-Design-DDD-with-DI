import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/services/product_cubit.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.red[50],
        title: Row(
          children: const [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text('Error', style: TextStyle(color: Colors.red)),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.fixed, // ensure it's at the bottom
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<ProductCubit>().loadProducts(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ProductCubit, ProductState>(
                listener: (context, state) {
                  // Show error dialog
                  if (state.error != null) {
                    _showErrorDialog(context, state.error!);
                  }
                },
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.products.isEmpty) {
                    return const Center(child: Text('No products available.'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            product.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.close_rounded, size: 40),
                            color: Colors.red,
                            onPressed: () async {
                              await context.read<ProductCubit>().deleteProduct(product.id);
                              _showSnackBar(context, 'Product deleted successfully');
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Product Name',
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Price',
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        final name = nameController.text.trim();
                        final price = double.tryParse(priceController.text) ?? 0.0;

                        if (name.isNotEmpty && price > 0) {
                          await context.read<ProductCubit>().addNewProduct(name, price);
                          nameController.clear();
                          priceController.clear();
                          _showSnackBar(context, 'Product added successfully');
                        }
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ProductCubit>().loadProducts(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
