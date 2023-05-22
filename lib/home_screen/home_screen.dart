import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvin_app_moc/home_screen/products_bloc/products_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                child: Text('coucou'),
                onPressed: () {
                  final productsBloc = BlocProvider.of<ProductsBloc>(context);
                  productsBloc.add(GetAllProducts(10));
                },
              ),
            ),
          );
        }
      ),
    );
  }
}
