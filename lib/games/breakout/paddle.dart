/// Paddle — the player-controlled component in Breakout.
///
/// Responds to horizontal drag gestures and stays within screen bounds.
library;

import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/collisions.dart';
import '../../core/constants.dart';
import 'breakout_game.dart';

/// The player-controlled paddle at the bottom of the Breakout arena.
class Paddle extends PositionComponent
    with DragCallbacks, CollisionCallbacks, HasGameReference<BreakoutGame> {
  Paddle()
      : super(
          size: Vector2(kBreakoutPaddleWidth, kBreakoutPaddleHeight),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    // Move paddle by the delta of the drag gesture.
    position.x += event.localDelta.x;
    // Clamp within the visible screen.
    position.x = position.x.clamp(
      size.x / 2,
      game.size.x - size.x / 2,
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = const Color(0xFF7C3AED); // kAccent violet
    final rect = Rect.fromCenter(
      center: Offset(size.x / 2, size.y / 2),
      width: size.x,
      height: size.y,
    );
    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(8));
    canvas.drawRRect(rRect, paint);
  }
}
