import 'package:marvin_app_moc/home_screen/data_sources/fruits_data_source.dart';

class FruitsRepository {
  final FruitsDataSource remoteDataSource;
  final FruitsDataSource localDataSource;

  FruitsRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<List<String>> getFruits() async {
    try {
      final fruits = await remoteDataSource.getFruits();
      return fruits;
    } catch (e) {
      final fruits = await localDataSource.getFruits();
      return fruits;
    }
  }
}
