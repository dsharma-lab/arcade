/// GameOverOverlay — a reusable game-over/win overlay widget.
///
/// Used by all mini-games to display the result, score, high score,
/// and Play Again / Home buttons.
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/router/app_router.dart';

/// Visual result of the game session.
enum GameResult { win, lose }

/// Overlay displayed when a mini-game session ends.
///
/// [result]: whether the player won or lost.
/// [score]: final score for this session.
/// [highScore]: all-time high score for this game.
/// [onPlayAgain]: callback to restart the game.
class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay({
    super.key,
    required this.result,
    required this.score,
    required this.highScore,
    required this.onPlayAgain,
  });

  final GameResult result;
  final int score;
  final int highScore;
  final VoidCallback onPlayAgain;

  bool get _isWin => result == GameResult.win;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.85),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppTheme.kSurface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isWin ? AppTheme.kGold : AppTheme.kError,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _isWin ? '🏆 You Win!' : '💀 Game Over',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 36,
                      color: _isWin ? AppTheme.kGold : AppTheme.kError,
                    ),
              ),
              const SizedBox(height: 20),
              _ScoreLine(label: 'Score', value: score),
              const SizedBox(height: 8),
              _ScoreLine(label: 'Best', value: highScore),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  key: const Key('play_again_button'),
                  onPressed: onPlayAgain,
                  child: const Text('Play Again'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  key: const Key('home_button'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.kTextSecondary,
                    side: const BorderSide(color: AppTheme.kTextSecondary),
                  ),
                  onPressed: () => context.go(AppRoutes.home),
                  child: const Text('Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single score label + value row inside the overlay.
class _ScoreLine extends StatelessWidget {
  const _ScoreLine({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          '$value',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppTheme.kTextPrimary),
        ),
      ],
    );
  }
}
