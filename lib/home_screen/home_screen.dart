import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvin_app_moc/home_screen/cart_screen/cart_screen.dart';
import 'package:marvin_app_moc/home_screen/models/product.dart';
import 'package:marvin_app_moc/home_screen/product_detail_screen/product_detail_screen.dart';
import 'package:marvin_app_moc/home_screen/product_item.dart';
import 'package:marvin_app_moc/home_screen/products_bloc/products_bloc.dart';
import 'package:marvin_app_moc/home_screen/repository/products_repository.dart';

import 'cart_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(
        repository: RepositoryProvider.of<ProductsRepository>(context),
      )..add(GetAllProducts(10)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Produits'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CartIcon(
                    onTap: () => _onCartTap(context),
                  ),
                ),
              ],
            ),
            body: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                switch (state.status) {
                  case ProductsStatus.initial:
                    return const SizedBox();
                  case ProductsStatus.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ProductsStatus.error:
                    return Center(
                      child: Text(state.error),
                    );
                  case ProductsStatus.success:
                    final products = state.products;

                    if (products.isEmpty) {
                      return const Center(
                        child: Text('Aucun produit'),
                      );
                    }

                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductItem(
                          product: product,
                          onTap: () => _onProductTap(context, product),
                        );
                      },
                    );
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.refresh),
              onPressed: () => _onRefreshList(context),
            ),
          );
        },
      ),
    );
  }

  void _onCartTap(BuildContext context) {
    CartScreen.navigateTo(context);
  }

  void _onRefreshList(BuildContext context) {
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    productsBloc.add(GetAllProducts(10));
  }

  void _onProductTap(BuildContext context, Product product) {
    ProductDetailScreen.navigateTo(context, product);
  }
}
