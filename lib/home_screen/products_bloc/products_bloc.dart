import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<GetAllProducts>((event, emit) {
      final count = event.count;
      debugPrint('Get All Products ($count)');
    });
  }
}
