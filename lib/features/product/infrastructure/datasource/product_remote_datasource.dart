import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRemoteDataSource implements ProductRepository {
  final List<Product> _products = [
    const Product(id: '1', name: 'iPhone 15', price: 999.0),
    const Product(id: '2', name: 'MacBook Air', price: 1299.0),
    const Product(id: '3', name: 'Apple Watch', price: 499.0),
  ];

  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 500)); // simulate delay
    return List.unmodifiable(_products); // return a copy
  }

  @override
  Future<void> addProduct(Product product) async {
    await Future.delayed(const Duration(milliseconds: 300)); // simulate delay
    _products.add(product);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _products.removeWhere((prod) => prod.id == id);
  }
}

// for api connection
// class ProductApiDataSource implements ProductRepository {
//   final http.Client client;
//
//   ProductApiDataSource(this.client);
//
//   static const String baseUrl = 'https://fakestoreapi.com/products';
//
//   @override
//   Future<List<Product>> getProducts() async {
//     final response = await client.get(Uri.parse(baseUrl));
//
//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       return data.map((json) {
//         return Product(
//           id: json['id'],
//           name: json['title'],
//           price: (json['price'] as num).toDouble(),
//         );
//       }).toList();
//     } else {
//       throw Exception('Failed to load products: ${response.statusCode}');
//     }
//   }
// }