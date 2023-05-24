import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvin_app_moc/home_screen/cart_bloc/cart_bloc.dart';
import 'package:marvin_app_moc/home_screen/cart_screen/cart_screen.dart';
import 'package:marvin_app_moc/home_screen/data_sources/remote_fruits_data_source.dart';
import 'package:marvin_app_moc/home_screen/fruits_repository_provider.dart';
import 'package:marvin_app_moc/home_screen/home_screen.dart';
import 'package:marvin_app_moc/home_screen/models/product.dart';
import 'package:marvin_app_moc/home_screen/product_detail_screen/product_detail_screen.dart';
import 'package:marvin_app_moc/home_screen/repository/fruits_repository.dart';

import 'home_screen/data_sources/local_fruits_data_source.dart';

void main() {
  const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'coucou');
  debugPrint('API_BASE_URL: $apiBaseUrl');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FruitsRepositoryProvider(
      fruitsRepository: FruitsRepository(
        localDataSource: LocalFruitsDataSource(),
        remoteDataSource: RemoteFruitsDataSource(),
      ),
      child: BlocProvider(
        create: (context) => CartBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: const TextTheme(
              bodySmall: TextStyle(
                fontSize: 20,
                color: Colors.orange,
              ),
            ),
          ),
          routes: {
            '/': (context) => const HomeScreen(),
            CartScreen.routeName: (context) => const CartScreen(),
          },
          onGenerateRoute: (settings) {
            Widget content = const SizedBox.shrink();

            switch (settings.name) {
              case ProductDetailScreen.routeName:
                final arguments = settings.arguments;
                if (arguments is Product) {
                  content = ProductDetailScreen(product: arguments);
                }
                break;
            }

            return MaterialPageRoute(
              builder: (context) {
                return content;
              },
            );
          },
        ),
      ),
    );
  }
}
