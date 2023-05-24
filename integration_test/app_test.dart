import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:marvin_app_moc/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Add product 3 to cart', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('Produits'), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));

      // Tap on producti item
      await tester.tap(find.text('Product 1'));
      await tester.pumpAndSettle();

      expect(find.text('Product 1'), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
