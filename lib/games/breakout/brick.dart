/// Brick — a destructible target component in Breakout.
///
/// Removes itself from the game when hit by the ball and notifies the
/// Breakout provider to update the score and remaining brick count.
library;

import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart' show Color;
import 'breakout_game.dart';

/// A single destructible brick.
///
/// [row] and [col] identify this brick's position in the grid.
class Brick extends PositionComponent
    with CollisionCallbacks, HasGameReference<BreakoutGame> {
  Brick({required this.row, required this.col, required Vector2 brickSize})
      : super(size: brickSize, anchor: Anchor.topLeft);

  final int row;
  final int col;

  /// Whether this brick has already been destroyed.
  bool _destroyed = false;

  // Cycle through a set of vibrant colours per row.
  static const _rowColors = [
    Color(0xFFEF4444), // red
    Color(0xFFF97316), // orange
    Color(0xFFEAB308), // yellow
    Color(0xFF10B981), // green
    Color(0xFF3B82F6), // blue
  ];

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = _rowColors[row % _rowColors.length];
    final rect = Rect.fromLTWH(0, 0, size.x, size.y).deflate(2);
    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(4));
    canvas.drawRRect(rRect, paint);
  }

  /// Destroys this brick and notifies the provider.
  void destroy() {
    if (_destroyed) return;
    _destroyed = true;
    game.onBrickDestroyed();
    removeFromParent();
  }
}
