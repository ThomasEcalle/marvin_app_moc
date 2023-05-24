import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:marvin_app_moc/home_screen/models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddProduct>((event, emit) async {
      emit(state.copyWith(status: CartStatus.loading));
      final product = event.product;
      await Future.delayed(const Duration(seconds: 3));
      try {
        if (product.id == '2') {
          throw Exception();
        }

        emit(
          state.copyWith(
            status: CartStatus.updated,
            products: [
              ...state.products,
              product,
            ],
          ),
        );
      } catch (error) {
        emit(state.copyWith(status: CartStatus.error, error: 'une erreur est survenue'));
      }
    });
  }
}
