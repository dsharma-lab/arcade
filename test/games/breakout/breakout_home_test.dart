import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamevault/app.dart';

void main() {
  testWidgets('Home screen shows all three game cards', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: GameVaultApp()),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('game_card_breakout')), findsOneWidget);
    expect(find.byKey(const Key('game_card_tictactoe')), findsOneWidget);
    expect(find.byKey(const Key('game_card_snake')), findsOneWidget);
  });

  testWidgets('Breakout game card is active (no "Soon" badge on Breakout)', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: GameVaultApp()),
    );
    await tester.pumpAndSettle();

    // Find the Breakout card specifically, then verify it has no "Soon" child.
    final breakoutCard = find.byKey(const Key('game_card_breakout'));
    expect(breakoutCard, findsOneWidget);

    // The Breakout card should show 'Breakout' title but NOT have 'Soon' as a
    // descendant of itself — only the Snake card is "Coming Soon".
    final soonInBreakout = find.descendant(
      of: breakoutCard,
      matching: find.text('Soon'),
    );
    expect(soonInBreakout, findsNothing);
  });

  testWidgets('Snake card still shows "Coming Soon"', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: GameVaultApp()),
    );
    await tester.pumpAndSettle();

    final snakeCard = find.byKey(const Key('game_card_snake'));
    final soonInSnake = find.descendant(
      of: snakeCard,
      matching: find.text('Soon'),
    );
    expect(soonInSnake, findsOneWidget);
  });
}
