import 'package:marvin_app_moc/home_screen/data_sources/products_data_source.dart';

import '../models/product.dart';

class ProductsRepository {
  final ProductsDataSource remoteDataSource;

  ProductsRepository({
    required this.remoteDataSource,
  });

  Future<List<Product>> getProducts() async {
    try {
      final products = await remoteDataSource.getProducts();
      return products;
    } catch (e) {
      rethrow;
    }
  }
}
