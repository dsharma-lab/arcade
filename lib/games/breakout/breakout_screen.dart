/// BreakoutScreen — Flutter screen that embeds the BreakoutGame Flame widget.
///
/// Wires Riverpod state to the Flame game, shows the score HUD, and displays
/// the GameOverOverlay when the game ends.
library;

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/storage/storage_service.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/game_over_overlay.dart';
import 'breakout_game.dart';
import 'breakout_provider.dart';

/// The top-level Flutter screen for the Breakout mini-game.
class BreakoutScreen extends ConsumerStatefulWidget {
  const BreakoutScreen({super.key});

  @override
  ConsumerState<BreakoutScreen> createState() => _BreakoutScreenState();
}

class _BreakoutScreenState extends ConsumerState<BreakoutScreen> {
  late BreakoutGame _game;

  @override
  void initState() {
    super.initState();
    _createGame();
    _loadHighScore();
  }

  /// Creates a new game instance, passing Riverpod callbacks.
  void _createGame() {
    _game = BreakoutGame(
      onBrickDestroyed: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) ref.read(breakoutProvider.notifier).brickDestroyed();
        });
      },
      onBallLost: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) ref.read(breakoutProvider.notifier).ballLost();
        });
      },
      currentPhase: () => ref.read(breakoutProvider).phase,
    );
  }

  /// Reads the persisted high score from Hive and seeds the provider.
  Future<void> _loadHighScore() async {
    final highScore = await StorageService.instance.getHighScore('breakout');
    if (mounted) {
      ref.read(breakoutProvider.notifier).setHighScore(highScore);
    }
  }

  /// Persists the current session score if it's a new high score.
  Future<void> _persistScore(int score) async {
    await StorageService.instance.saveHighScore('breakout', score);
  }

  void _playAgain() {
    ref.read(breakoutProvider.notifier).resetGame();
    _game.resetGame();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(breakoutProvider);
    final isOver = state.phase != BreakoutPhase.playing;

    // Persist when the game ends.
    if (isOver) {
      _persistScore(state.score);
    }

    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      body: SafeArea(
        child: Stack(
          children: [
            // --- Flame game canvas ---
            GameWidget(game: _game),

            // --- Score HUD ---
            Positioned(
              top: 12,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${state.score}',
                    key: const Key('breakout_score'),
                    style: const TextStyle(
                      color: AppTheme.kTextPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Best ${state.highScore}',
                    style: const TextStyle(
                      color: AppTheme.kTextSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // --- Bricks remaining indicator ---
            Positioned(
              top: 12,
              right: 16,
              child: Text(
                '🧱 ${state.bricksRemaining}',
                style: const TextStyle(
                  color: AppTheme.kTextSecondary,
                  fontSize: 14,
                ),
              ),
            ),

            // --- Game Over / Win overlay ---
            if (isOver)
              GameOverOverlay(
                result: state.phase == BreakoutPhase.won
                    ? GameResult.win
                    : GameResult.lose,
                score: state.score,
                highScore: state.highScore,
                onPlayAgain: _playAgain,
              ),
          ],
        ),
      ),
    );
  }
}
