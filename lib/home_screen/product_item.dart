import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvin_app_moc/home_screen/cart_bloc/cart_bloc.dart';

import 'models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductItem({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text(product.description),
      trailing: Text("${product.price} €"),
      leading: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: BlocBuilder<CartBloc, CartState>(
            buildWhen: (previous, next) {
              final previousOccurrences = previous.products.where((element) => element.id == product.id).length;
              final nextOccurrences = next.products.where((element) => element.id == product.id).length;

              return previousOccurrences != nextOccurrences;
            },
            builder: (context, state) {
              debugPrint('Building item ${product.name}');
              final products = state.products;
              final occurrences = products.where((element) => element.id == product.id).length;
              return Text(
                '$occurrences',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              );
            },
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
