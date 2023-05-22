import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvin_app_moc/home_screen/products_bloc/products_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc()..add(GetAllProducts(10)),
      child: Builder(builder: (context) {
        return Scaffold(
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
                      return ListTile(
                        title: Text(product.name),
                      );
                    },
                  );
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              final productsBloc = BlocProvider.of<ProductsBloc>(context);
              productsBloc.add(GetAllProducts(10));
            },
          ),
        );
      }),
    );
  }
}
