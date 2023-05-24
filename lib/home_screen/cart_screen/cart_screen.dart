import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvin_app_moc/home_screen/cart_bloc/cart_bloc.dart';
import 'package:marvin_app_moc/home_screen/product_item.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/CartScreen';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier d\'achats'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final products = state.products;

          if (products.isEmpty) {
            return const Center(
              child: Text('Votre panier est vide'),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItem(product: product);
            },
          );
        },
      ),
    );
  }
}
