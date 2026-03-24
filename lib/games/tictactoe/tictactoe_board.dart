/// Pure game logic for Tic Tac Toe — board state and win detection.
///
/// No Flutter or Flame imports allowed here.
import '../../core/constants.dart';

/// Immutable board cell state.
typedef Board = List<List<String?>>;

/// Returns a fresh empty 3×3 board.
Board emptyBoard() => List.generate(
      kBoardSize, (_) => List.filled(kBoardSize, null),
    );

/// Returns the winner symbol ('X' or 'O'), 'draw', or null if game continues.
String? checkWinner(Board board) {
  // Check rows and columns
  for (int i = 0; i < kBoardSize; i++) {
    if (_allSame(board[i][0], board[i][1], board[i][2])) return board[i][0];
    if (_allSame(board[0][i], board[1][i], board[2][i])) return board[0][i];
  }
  // Check diagonals
  if (_allSame(board[0][0], board[1][1], board[2][2])) return board[0][0];
  if (_allSame(board[0][2], board[1][1], board[2][0])) return board[0][2];

  // Draw check
  if (isBoardFull(board)) return 'draw';
  return null;
}

/// Returns true if all cells in the board are filled.
bool isBoardFull(Board board) {
  for (final row in board) {
    if (row.contains(null)) return false;
  }
  return true;
}

bool _allSame(String? a, String? b, String? c) =>
    a != null && a == b && b == c;
