import 'package:flutter/widgets.dart';
import 'package:marvin_app_moc/home_screen/data_sources/products_data_source.dart';
import 'package:marvin_app_moc/home_screen/models/product.dart';

class LocalFruitsDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getProducts() {
    debugPrint('Getting fruits from local data source');
    return Future.value([]);
  }
}
