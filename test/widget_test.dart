// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvin_app_moc/home_screen/cart_bloc/cart_bloc.dart';
import 'package:marvin_app_moc/home_screen/data_sources/products_data_source.dart';
import 'package:marvin_app_moc/home_screen/home_screen.dart';
import 'package:marvin_app_moc/home_screen/models/product.dart';
import 'package:marvin_app_moc/home_screen/repository/products_repository.dart';

class EmptyRemoteDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return [];
  }
}

class FailingRemoteDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('Error');
  }
}

void main() {
  testWidgets('Products Screen with succee', (WidgetTester tester) async {
    await tester.pumpWidget(
      RepositoryProvider(
        create: (context) => ProductsRepository(
          remoteDataSource: EmptyRemoteDataSource(),
        ),
        child: BlocProvider(
          create: (context) => CartBloc(),
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Produits'), findsOneWidget);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    expect(find.text('Aucun produit'), findsOneWidget);
  });

  testWidgets('Products Screen with error', (WidgetTester tester) async {
    await tester.pumpWidget(
      RepositoryProvider(
        create: (context) => ProductsRepository(
          remoteDataSource: FailingRemoteDataSource(),
        ),
        child: BlocProvider(
          create: (context) => CartBloc(),
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Produits'), findsOneWidget);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    expect(find.text(Exception('Error').toString()), findsOneWidget);
  });
}
