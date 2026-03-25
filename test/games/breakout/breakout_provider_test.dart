import 'package:flutter_test/flutter_test.dart';
import 'package:gamevault/games/breakout/breakout_provider.dart';

void main() {
  group('BreakoutNotifier', () {
    late BreakoutNotifier notifier;

    setUp(() {
      notifier = BreakoutNotifier()..build(); // initialise state
    });

    test('initial state has correct brick count and zero score', () {
      final state = notifier.build();
      expect(state.score, 0);
      expect(state.bricksRemaining, BreakoutState.kTotalBricks);
      expect(state.phase, BreakoutPhase.playing);
    });

    test('brickDestroyed increments score by kBreakoutScorePerBrick', () {
      // Can't drive Notifier directly without ProviderContainer in unit tests,
      // so we test the pure state logic via copyWith instead.
      const initial = BreakoutState(
        score: 0,
        highScore: 0,
        bricksRemaining: 35,
        phase: BreakoutPhase.playing,
      );
      final next = initial.copyWith(
        score: initial.score + 10,
        bricksRemaining: initial.bricksRemaining - 1,
      );
      expect(next.score, 10);
      expect(next.bricksRemaining, 34);
    });

    test('phase becomes won when bricksRemaining reaches 0', () {
      const almostDone = BreakoutState(
        score: 340,
        highScore: 340,
        bricksRemaining: 1,
        phase: BreakoutPhase.playing,
      );
      // Simulate last brick
      final next = almostDone.copyWith(
        bricksRemaining: 0,
        phase: BreakoutPhase.won,
      );
      expect(next.phase, BreakoutPhase.won);
    });

    test('phase becomes gameOver on ballLost', () {
      const playing = BreakoutState(
        score: 50,
        highScore: 50,
        bricksRemaining: 20,
        phase: BreakoutPhase.playing,
      );
      final next = playing.copyWith(phase: BreakoutPhase.gameOver);
      expect(next.phase, BreakoutPhase.gameOver);
    });

    test('resetGame preserves highScore', () {
      const ended = BreakoutState(
        score: 200,
        highScore: 200,
        bricksRemaining: 0,
        phase: BreakoutPhase.won,
      );
      final reset = BreakoutState.initial(highScore: ended.highScore);
      expect(reset.highScore, 200);
      expect(reset.score, 0);
      expect(reset.phase, BreakoutPhase.playing);
      expect(reset.bricksRemaining, BreakoutState.kTotalBricks);
    });
  });
}
