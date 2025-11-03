import 'package:domain_drive_design/features/product/domain/usecases/delete_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/get_products.dart';

class ProductState {
  final List<Product> products;
  final bool loading;
  final String? error;

  const ProductState({
    this.products = const [],
    this.loading = false,
    this.error,
  });

  ProductState copyWith({
    List<Product>? products,
    bool? loading,
    String? error,
  }) {
    return ProductState(
      products: products ?? this.products,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}

class ProductCubit extends Cubit<ProductState> {
  final GetProducts _getProducts;
  final AddProduct _addProduct;
  final DeleteProduct _deleteProduct;

  ProductCubit(this._getProducts, this._addProduct, this._deleteProduct) : super(const ProductState());

  Future<void> loadProducts() async {
    emit(state.copyWith(loading: true));
    try {
      final products = await _getProducts.get();
      emit(state.copyWith(products: products, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  Future<void> addNewProduct(String name, double price) async {
    emit(state.copyWith(loading: true));
    try {
      final newProduct = Product(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        price: price,
      );
      await _addProduct.add(newProduct);
      final updatedProducts = await _getProducts.get();
      emit(state.copyWith(products: updatedProducts, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  Future<void> deleteProduct(String id) async{
    emit(state.copyWith(loading: true));
    try{
      await _deleteProduct.delete(id);
      final updatedProducts = await _getProducts.get();
      emit(state.copyWith(products: updatedProducts, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }
}
