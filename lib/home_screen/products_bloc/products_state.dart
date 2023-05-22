part of 'products_bloc.dart';

enum ProductsStatus {
  initial,
  loading,
  success,
  error,
}

class ProductsState {
  final ProductsStatus status;
  final List<Product> products;
  final String error;

  ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.error = '',
  });

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
    String? error,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      error: error ?? this.error,
    );
  }
}
