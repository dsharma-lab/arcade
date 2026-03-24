/// TicTacToeGame — Flame game class handling rendering and touch input.
///
/// Communicates with Riverpod state via [TicTacToeNotifier].
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import '../../core/theme/app_theme.dart';
import 'tictactoe_provider.dart';

class TicTacToeGame extends FlameGame with TapCallbacks {
  TicTacToeGame({required this.ref});

  final WidgetRef ref;

  // Board rendering config
  static const _cellSize = 100.0;
  static const _lineWidth = 4.0;
  static final _linePaint = Paint()
    ..color = AppTheme.kAccent
    ..strokeWidth = _lineWidth
    ..strokeCap = StrokeCap.round;

  late double _boardOffset;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _boardOffset = (size.x - _cellSize * kBoardSize) / 2;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _drawGrid(canvas);
    _drawPieces(canvas);
  }

  void _drawGrid(Canvas canvas) {
    for (int i = 1; i < kBoardSize; i++) {
      // Vertical lines
      canvas.drawLine(
        Offset(_boardOffset + i * _cellSize, _boardOffset),
        Offset(_boardOffset + i * _cellSize, _boardOffset + _cellSize * kBoardSize),
        _linePaint,
      );
      // Horizontal lines
      canvas.drawLine(
        Offset(_boardOffset, _boardOffset + i * _cellSize),
        Offset(_boardOffset + _cellSize * kBoardSize, _boardOffset + i * _cellSize),
        _linePaint,
      );
    }
  }

  void _drawPieces(Canvas canvas) {
    final state = ref.read(ticTacToeProvider);
    for (int row = 0; row < kBoardSize; row++) {
      for (int col = 0; col < kBoardSize; col++) {
        final cell = state.board[row][col];
        final center = Offset(
          _boardOffset + col * _cellSize + _cellSize / 2,
          _boardOffset + row * _cellSize + _cellSize / 2,
        );
        if (cell == kPlayerX) {
          _drawX(canvas, center);
        } else if (cell == kPlayerO) {
          _drawO(canvas, center);
        }
      }
    }
  }

  void _drawX(Canvas canvas, Offset center) {
    final paint = Paint()
      ..color = AppTheme.kError
      ..strokeWidth = _lineWidth
      ..strokeCap = StrokeCap.round;
    const halfSize = 30.0;
    canvas.drawLine(center.translate(-halfSize, -halfSize),
        center.translate(halfSize, halfSize), paint);
    canvas.drawLine(center.translate(halfSize, -halfSize),
        center.translate(-halfSize, halfSize), paint);
  }

  void _drawO(Canvas canvas, Offset center) {
    final paint = Paint()
      ..color = AppTheme.kSuccess
      ..strokeWidth = _lineWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, 30, paint);
  }

  @override
  void onTapDown(TapDownEvent event) {
    final tapPos = event.localPosition;
    final col = ((tapPos.x - _boardOffset) / _cellSize).floor();
    final row = ((tapPos.y - _boardOffset) / _cellSize).floor();

    if (row >= 0 && row < kBoardSize && col >= 0 && col < kBoardSize) {
      ref.read(ticTacToeProvider.notifier).makeMove(row, col);
    }
  }
}
