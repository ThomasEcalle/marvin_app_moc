import 'package:flutter/widgets.dart';
import 'package:marvin_app_moc/home_screen/data_sources/fruits_data_source.dart';

class LocalFruitsDataSource extends FruitsDataSource {
  @override
  Future<List<String>> getFruits() {
    debugPrint('Getting fruits from local data source');
    return Future.value(['Apple', 'Banana', 'Orange']);
  }
}
