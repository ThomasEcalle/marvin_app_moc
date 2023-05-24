import 'package:flutter/material.dart';
import 'package:marvin_app_moc/home_screen/repository/products_repository.dart';

class FruitsRepositoryProvider extends InheritedWidget {
  const FruitsRepositoryProvider({
    Key? key,
    required Widget child,
    required this.fruitsRepository,
  }) : super(key: key, child: child);

  final ProductsRepository fruitsRepository;

  static FruitsRepositoryProvider of(BuildContext context) {
    final FruitsRepositoryProvider? result = context.dependOnInheritedWidgetOfExactType<FruitsRepositoryProvider>();
    assert(result != null, 'No FruitsRepositoryProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(FruitsRepositoryProvider old) {
    return true;
  }
}
