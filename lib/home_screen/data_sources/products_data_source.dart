import 'package:marvin_app_moc/home_screen/models/product.dart';

abstract class ProductsDataSource {
  Future<List<Product>> getProducts();
}