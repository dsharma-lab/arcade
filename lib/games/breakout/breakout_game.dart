/// BreakoutGame — the Flame game class for Breakout.
///
/// Manages the game world: ball, paddle, bricks, and overlays.
/// Bridges the Flame game loop to the Riverpod provider via callbacks.
library;

import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../../core/constants.dart';
import 'ball.dart';
import 'paddle.dart';
import 'brick.dart';
import 'breakout_provider.dart';

/// Callback signatures so [BreakoutScreen] can wire in the Riverpod notifier.
typedef VoidGameCallback = void Function();

/// The Flame game world for Breakout.
///
/// Call [onBrickDestroyed] and [onBallLost] to update Riverpod state from the
/// game loop without importing Riverpod into Flame directly.
class BreakoutGame extends FlameGame with HasCollisionDetection {
  BreakoutGame({
    required this.onBrickDestroyed,
    required this.onBallLost,
    required this.currentPhase,
  });

  /// Called when a brick is destroyed — increments Riverpod score.
  final VoidGameCallback onBrickDestroyed;

  /// Called when the ball falls off screen — triggers game over.
  final VoidGameCallback onBallLost;

  /// Supplier for the current game phase (read from Riverpod state).
  final BreakoutPhase Function() currentPhase;

  /// Exposes the current phase to components.
  BreakoutPhase get phase => currentPhase();

  late Ball _ball;
  late Paddle _paddle;

  @override
  Color backgroundColor() => const Color(0xFF0D0D1A); // kBackground

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(ScreenHitbox());
    _buildBricks();
    _paddle = Paddle();
    _ball = Ball();
    await addAll([_paddle, _ball]);
    _positionPaddle();
    _positionBall();
  }

  // ---------------------------------------------------------------------------
  // Layout helpers
  // ---------------------------------------------------------------------------

  /// Places the paddle at the bottom-centre of the screen.
  void _positionPaddle() {
    _paddle.position = Vector2(
      size.x / 2,
      size.y - kBreakoutPaddleBottomOffset,
    );
  }

  /// Positions the ball just above the paddle's centre.
  void _positionBall() {
    _ball.position = Vector2(
      size.x / 2,
      size.y - kBreakoutPaddleBottomOffset - kBreakoutPaddleHeight - kBreakoutBallRadius - 4,
    );
  }

  /// Builds the full brick grid.
  void _buildBricks() {
    const topMargin = 80.0;
    const sidePadding = 12.0;
    final totalWidth = size.x - sidePadding * 2;
    final brickWidth =
        (totalWidth - kBreakoutBrickGap * (kBreakoutBrickCols - 1)) /
            kBreakoutBrickCols;
    final brickSize = Vector2(brickWidth, kBreakoutBrickHeight);

    for (int row = 0; row < kBreakoutBrickRows; row++) {
      for (int col = 0; col < kBreakoutBrickCols; col++) {
        final brick = Brick(row: row, col: col, brickSize: brickSize);
        brick.position = Vector2(
          sidePadding + col * (brickWidth + kBreakoutBrickGap),
          topMargin + row * (kBreakoutBrickHeight + kBreakoutBrickGap),
        );
        add(brick);
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Public reset
  // ---------------------------------------------------------------------------

  /// Resets the game world for a "Play Again" without re-creating the widget.
  void resetGame() {
    removeAll(children.whereType<Brick>().toList());
    _ball.removeFromParent();
    _buildBricks();
    _ball = Ball();
    add(_ball);
    _positionBall();
    _positionPaddle();
  }
}
