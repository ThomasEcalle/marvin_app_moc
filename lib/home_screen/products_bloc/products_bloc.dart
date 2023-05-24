import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../repository/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository repository;

  ProductsBloc({required this.repository}) : super(ProductsState()) {
    on<GetAllProducts>((event, emit) async {
      emit(state.copyWith(status: ProductsStatus.loading));

      final count = event.count;

      try {
        final products = await repository.getProducts();
        emit(state.copyWith(status: ProductsStatus.success, products: products));
      } catch (error) {
        emit(state.copyWith(status: ProductsStatus.error, error: error.toString()));
      }
    });
  }
}
