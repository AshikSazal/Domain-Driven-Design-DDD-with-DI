import '../repositories/product_repository.dart';

class DeleteProduct{
  final ProductRepository repository;
  DeleteProduct(this.repository);

  Future<void> delete(String id) async{
    await repository.deleteProduct(id);
  }
}