import 'package:flutter/cupertino.dart';

import 'fruits_data_source.dart';

class RemoteFruitsDataSource extends FruitsDataSource {
  @override
  Future<List<String>> getFruits() async {
    debugPrint('Getting fruits from remote data source');
    await Future.delayed(const Duration(seconds: 2));
    return ['Apple', 'Banana', 'Orange'];
  }
}
