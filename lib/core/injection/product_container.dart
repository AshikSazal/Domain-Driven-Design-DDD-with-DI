import 'package:domain_drive_design/features/product/domain/usecases/delete_product.dart';
import 'package:get_it/get_it.dart';
import '../../features/product/application/services/product_cubit.dart';
import '../../features/product/domain/usecases/add_product.dart';
import '../../features/product/domain/usecases/get_products.dart';
import '../../features/product/infrastructure/datasource/product_remote_datasource.dart';

final sl = GetIt.instance; // 'sl' = Service Locator

Future<void> initDependencies() async {
  // --- Product Feature ---

  // Data source (repository)
  sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSource());

  // Use cases
  sl.registerLazySingleton<GetProducts>(() => GetProducts(sl<ProductRemoteDataSource>()));
  sl.registerLazySingleton<AddProduct>(() => AddProduct(sl<ProductRemoteDataSource>()));
  sl.registerLazySingleton<DeleteProduct>(() => DeleteProduct(sl<ProductRemoteDataSource>()));

  // Cubit / Bloc
  sl.registerFactory<ProductCubit>(() => ProductCubit(sl<GetProducts>(), sl<AddProduct>(), sl<DeleteProduct>()));
}


// for api call
// Future<void> initDependencies() async {
//   // --- HTTP Client ---
//   sl.registerLazySingleton<http.Client>(() => http.Client());
//
//   // --- Product Feature ---
//
//   // Data source (repository)
//   sl.registerLazySingleton<ProductRemoteDataSource>(
//           () => ProductRemoteDataSource(client: sl<http.Client>()));
//
//   // Use cases
//   sl.registerLazySingleton<GetProducts>(() => GetProducts(sl<ProductRemoteDataSource>()));
//   sl.registerLazySingleton<AddProduct>(() => AddProduct(sl<ProductRemoteDataSource>()));
//   sl.registerLazySingleton<DeleteProduct>(() => DeleteProduct(sl<ProductRemoteDataSource>()));
//
//   // Cubit / Bloc
//   sl.registerFactory<ProductCubit>(
//           () => ProductCubit(sl<GetProducts>(), sl<AddProduct>(), sl<DeleteProduct>()));
// }