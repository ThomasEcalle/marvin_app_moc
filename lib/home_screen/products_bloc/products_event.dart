part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class GetAllProducts extends ProductsEvent {
  final int count;

  GetAllProducts(this.count);
}
