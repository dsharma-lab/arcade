/// Ball — the moving projectile component in Breakout.
///
/// Handles its own physics: constant velocity, wall bounces, and collision
/// responses with the Paddle and Brick components.
library;

import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../../core/constants.dart';
import 'breakout_game.dart';
import 'breakout_provider.dart';
import 'paddle.dart';
import 'brick.dart';

/// Extension to check if the game phase is no longer active.
extension on BreakoutPhase {
  bool get isOver => this != BreakoutPhase.playing;
}

/// The breakout ball with physics-based bouncing and collision detection.
class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<BreakoutGame> {
  Ball()
      : super(
          radius: kBreakoutBallRadius,
          anchor: Anchor.center,
        );

  /// Current velocity in pixels-per-second.
  Vector2 _velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint = Paint()..color = const Color(0xFFF1F1F1);
    add(CircleHitbox());
    _launchBall();
  }

  /// Launches the ball at a 45-degree-ish angle upward.
  void _launchBall() {
    const speed = kBreakoutBallSpeed;
    // 45° up-right with a small random horizontal sway.
    final angle = -pi / 4 + (Random().nextDouble() * pi / 6 - pi / 12);
    _velocity = Vector2(cos(angle) * speed, sin(angle) * speed);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (game.phase.isOver) return;

    position += _velocity * dt;
    _handleWallBounces();
    _checkFallOff();
  }

  /// Reflects the ball off left, right, and top screen edges.
  void _handleWallBounces() {
    final bounds = game.size;

    if (position.x - radius <= 0) {
      position.x = radius;
      _velocity.x = _velocity.x.abs();
    } else if (position.x + radius >= bounds.x) {
      position.x = bounds.x - radius;
      _velocity.x = -_velocity.x.abs();
    }

    if (position.y - radius <= 0) {
      position.y = radius;
      _velocity.y = _velocity.y.abs();
    }
  }

  /// Detects when the ball falls below the paddle → game over.
  void _checkFallOff() {
    if (position.y > game.size.y + radius) {
      game.onBallLost();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Paddle) {
      _onPaddleHit(other);
    } else if (other is Brick) {
      other.destroy();
      // Reflect off the brick — simple y-flip.
      _velocity.y = -_velocity.y.abs();
    }
  }

  /// Calculates the rebound angle based on where the ball hits the paddle.
  ///
  /// Hitting the left edge sends the ball left; the centre sends it straight
  /// up; the right edge sends it right. This makes paddle position meaningful.
  void _onPaddleHit(Paddle paddle) {
    final hitX = position.x - paddle.position.x;
    final normHit = (hitX / (kBreakoutPaddleWidth / 2)).clamp(-1.0, 1.0);
    const maxAngle = pi / 3; // 60°
    final angle = normHit * maxAngle - pi / 2;

    final speed = _velocity.length;
    _velocity = Vector2(cos(angle) * speed, sin(angle) * speed);
    // Ensure the ball always moves upward after hitting the paddle.
    _velocity.y = -_velocity.y.abs();
    // Prevent the ball from getting stuck inside the paddle.
    position.y = paddle.position.y - kBreakoutPaddleHeight / 2 - radius;
  }
}
