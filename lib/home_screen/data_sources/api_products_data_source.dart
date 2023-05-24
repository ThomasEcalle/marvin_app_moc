import '../models/product.dart';
import 'products_data_source.dart';

class ApiProductsDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(10, (index) {
      return Product(
        id: '$index',
        name: 'Product $index',
        description: 'Description $index',
        price: index + 5,
      );
    });
  }
}
