import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvin_app_moc/home_screen/cart_bloc/cart_bloc.dart';

class CartIcon extends StatelessWidget {
  final VoidCallback? onTap;

  const CartIcon({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previousState, nextState) {
        return nextState.status == CartStatus.updated;
      },
      builder: (context, state) {
        debugPrint('Building cart icon');
        return GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text('(${state.products.length})'),
              const Icon(Icons.shopping_cart),
            ],
          ),
        );
      },
    );
  }
}
