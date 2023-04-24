import 'package:flutter/material.dart';
import 'package:marvin_app_moc/home_screen/data_sources/remote_fruits_data_source.dart';
import 'package:marvin_app_moc/home_screen/fruits_repository_provider.dart';
import 'package:marvin_app_moc/home_screen/home_screen.dart';
import 'package:marvin_app_moc/home_screen/repository/fruits_repository.dart';

import 'home_screen/data_sources/local_fruits_data_source.dart';

void main() {
  const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'coucou');
  debugPrint('API_BASE_URL: $apiBaseUrl');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FruitsRepositoryProvider(
      fruitsRepository: FruitsRepository(
        localDataSource: LocalFruitsDataSource(),
        remoteDataSource: RemoteFruitsDataSource(),
      ),
      child: MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
            bodySmall: TextStyle(
              fontSize: 20,
              color: Colors.orange,
            ),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
