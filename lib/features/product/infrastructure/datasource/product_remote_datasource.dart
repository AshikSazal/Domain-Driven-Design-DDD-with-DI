import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductRemoteDataSource implements ProductRepository {
  final http.Client client;

  ProductRemoteDataSource(this.client);

  static const String baseUrl = 'http://192.168.0.153:3000';

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/get'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Product.fromMap(json)).toList();
      } else {
        throw Exception('Failed to fetch products: ${response.statusCode}');
      }
    } catch (e) {
      // You can log the error or handle it as needed
      print('Error in getProducts: $e');
      rethrow; // optionally rethrow to let higher layers handle it
    }
  }

  @override
  Future<void> addProduct(Product product) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toMap()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add product: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in addProduct: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/delete/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in deleteProduct: $e');
      rethrow;
    }
  }
}