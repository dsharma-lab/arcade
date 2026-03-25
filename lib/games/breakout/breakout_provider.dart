/// Riverpod providers for Breakout game state.
///
/// Tracks score, brick count, and game phase outside the Flame loop.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';

// ---------------------------------------------------------------------------
// Game Phase
// ---------------------------------------------------------------------------

/// All possible states for the Breakout game lifecycle.
enum BreakoutPhase { playing, gameOver, won }

// ---------------------------------------------------------------------------
// Breakout State
// ---------------------------------------------------------------------------

/// Immutable snapshot of Breakout game state managed outside the Flame loop.
class BreakoutState {
  const BreakoutState({
    required this.score,
    required this.highScore,
    required this.bricksRemaining,
    required this.phase,
  });

  final int score;
  final int highScore;
  final int bricksRemaining;
  final BreakoutPhase phase;

  /// Total brick count at the start of a game.
  static const kTotalBricks = kBreakoutBrickCols * kBreakoutBrickRows;

  /// Returns the initial state for the start of a new game.
  factory BreakoutState.initial({int highScore = 0}) => BreakoutState(
        score: 0,
        highScore: highScore,
        bricksRemaining: kTotalBricks,
        phase: BreakoutPhase.playing,
      );

  BreakoutState copyWith({
    int? score,
    int? highScore,
    int? bricksRemaining,
    BreakoutPhase? phase,
  }) =>
      BreakoutState(
        score: score ?? this.score,
        highScore: highScore ?? this.highScore,
        bricksRemaining: bricksRemaining ?? this.bricksRemaining,
        phase: phase ?? this.phase,
      );
}

// ---------------------------------------------------------------------------
// Breakout Notifier
// ---------------------------------------------------------------------------

/// Manages Breakout game state transitions.
class BreakoutNotifier extends Notifier<BreakoutState> {
  @override
  BreakoutState build() => BreakoutState.initial();

  /// Called when the player destroys a brick.
  void brickDestroyed() {
    final newScore = state.score + kBreakoutScorePerBrick;
    final newBricks = state.bricksRemaining - 1;
    final newHighScore =
        newScore > state.highScore ? newScore : state.highScore;

    state = state.copyWith(
      score: newScore,
      highScore: newHighScore,
      bricksRemaining: newBricks,
      phase: newBricks <= 0 ? BreakoutPhase.won : BreakoutPhase.playing,
    );
  }

  /// Called when the ball falls below the paddle.
  void ballLost() {
    state = state.copyWith(phase: BreakoutPhase.gameOver);
  }

  /// Resets the game to a fresh state, preserving the high score.
  void resetGame() {
    state = BreakoutState.initial(highScore: state.highScore);
  }

  /// Loads the persisted high score into state at game start.
  void setHighScore(int score) {
    state = state.copyWith(highScore: score);
  }
}

/// The single Riverpod provider for Breakout state.
final breakoutProvider =
    NotifierProvider<BreakoutNotifier, BreakoutState>(BreakoutNotifier.new);
