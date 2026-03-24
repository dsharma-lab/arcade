import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamevault/app.dart';

void main() {
  testWidgets('App loads and shows home screen title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: GameVaultApp(),
      ),
    );

    // Verify that our app title is shown.
    expect(find.text('GameVault'), findsOneWidget);
  });
}
