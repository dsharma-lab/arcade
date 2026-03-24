/// Minimax AI opponent for Tic Tac Toe with alpha-beta pruning.
///
/// AI always plays as [kPlayerO]. Returns the best move position.
import 'dart:math';

import '../../core/constants.dart';
import 'tictactoe_board.dart';

class Position {
  const Position(this.row, this.col);
  final int row;
  final int col;

  @override
  bool operator ==(Object other) =>
      other is Position && other.row == row && other.col == col;

  @override
  int get hashCode => Object.hash(row, col);

  @override
  String toString() => 'Position($row, $col)';
}

/// Returns the best [Position] for the AI using Minimax with alpha-beta pruning.
///
/// [board] must not be a won or full board — call [checkWinner] first.
Position getBestMove(Board board) {
  int bestScore = -999;
  Position bestMove = const Position(0, 0);

  for (int row = 0; row < kBoardSize; row++) {
    for (int col = 0; col < kBoardSize; col++) {
      if (board[row][col] == null) {
        board[row][col] = kPlayerO;
        final score = _minimax(board, 0, false, -999, 999);
        board[row][col] = null;
        if (score > bestScore) {
          bestScore = score;
          bestMove = Position(row, col);
        }
      }
    }
  }
  return bestMove;
}

int _minimax(Board board, int depth, bool isMaximizing, int alpha, int beta) {
  final result = checkWinner(board);
  if (result == kPlayerO) return 10 - depth;
  if (result == kPlayerX) return depth - 10;
  if (result == 'draw') return 0;

  if (isMaximizing) {
    int best = -999;
    for (int r = 0; r < kBoardSize; r++) {
      for (int c = 0; c < kBoardSize; c++) {
        if (board[r][c] == null) {
          board[r][c] = kPlayerO;
          best = max(best, _minimax(board, depth + 1, false, alpha, beta));
          board[r][c] = null;
          alpha = max(alpha, best);
          if (beta <= alpha) return best; // Prune
        }
      }
    }
    return best;
  } else {
    int best = 999;
    for (int r = 0; r < kBoardSize; r++) {
      for (int c = 0; c < kBoardSize; c++) {
        if (board[r][c] == null) {
          board[r][c] = kPlayerX;
          best = min(best, _minimax(board, depth + 1, true, alpha, beta));
          board[r][c] = null;
          beta = min(beta, best);
          if (beta <= alpha) return best; // Prune
        }
      }
    }
    return best;
  }
}
