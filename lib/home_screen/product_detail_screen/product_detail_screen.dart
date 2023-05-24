import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvin_app_moc/home_screen/cart_bloc/cart_bloc.dart';
import 'package:marvin_app_moc/home_screen/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/ProductDetailScreen';

  static void navigateTo(BuildContext context, Product product) {
    Navigator.of(context).pushNamed(routeName, arguments: product);
  }

  final Product product;

  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.description),
            const Spacer(),
            Center(
              child: BlocConsumer<CartBloc, CartState>(
                listener: (context, state) {
                  if (state.status == CartStatus.updated) {
                    _showSnackBar(context, 'Produit ajouté au panier');
                    Navigator.of(context).pop();
                  } else if (state.status == CartStatus.error) {
                    _showSnackBar(context, state.error ?? '');
                  }
                },
                builder: (context, state) {
                  switch (state.status) {
                    case CartStatus.loading:
                      return const CircularProgressIndicator();
                    default:
                      return _buildButton(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onAddToCart(context),
      child: Text('Ajouter au panier - ${product.price}€'),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void _onAddToCart(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(AddProduct(product));
  }
}
