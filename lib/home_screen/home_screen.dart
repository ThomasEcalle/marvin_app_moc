import 'package:flutter/material.dart';
import 'package:marvin_app_moc/home_screen/fruits_repository_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: FruitsRepositoryProvider.of(context).fruitsRepository.getFruits(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          if (snapshot.hasData) {
            final fruits = snapshot.data;
            if (fruits == null || fruits.isEmpty) {
              return Center(
                child: Text('No fruits found'),
              );
            }

            return ListView.builder(
              itemCount: fruits.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    fruits[index],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
