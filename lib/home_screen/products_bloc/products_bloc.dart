import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../models/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsState()) {
    on<GetAllProducts>((event, emit) async {
      emit(state.copyWith(status: ProductsStatus.loading));

      await Future.delayed(const Duration(seconds: 2));

      final count = event.count;
      debugPrint('Get All Products ($count)');

      try {
        final products = List.generate(count, (index) {
          return Product(
            id: '$index',
            name: 'Product $index',
            description: 'Description $index',
            price: index + 5,
          );
        });

        emit(state.copyWith(status: ProductsStatus.success, products: products));
      } catch (error) {
        emit(state.copyWith(status: ProductsStatus.error, error: error.toString()));
      }
    });
  }
}
