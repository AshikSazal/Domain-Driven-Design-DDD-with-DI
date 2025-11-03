import 'package:domain_drive_design/features/product/presentation/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/product/application/services/product_cubit.dart';
import 'core/injection/product_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App (DDD Example)',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => sl<ProductCubit>()..loadProducts(),
        child: const ProductPage(),
      ),
    );
  }
}
