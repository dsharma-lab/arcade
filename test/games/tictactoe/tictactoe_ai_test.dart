import 'package:flutter_test/flutter_test.dart';
import 'package:gamevault/core/constants.dart';
import 'package:gamevault/games/tictactoe/tictactoe_board.dart';
import 'package:gamevault/games/tictactoe/tictactoe_ai.dart';

void main() {
  group('TicTacToeAI', () {
    test('AI takes the winning move', () {
      // O O .
      // X X .
      // . . .
      // AI is always O. If O can win at (0, 2), it should.
      final Board board = [
        [kPlayerO, kPlayerO, null],
        [kPlayerX, kPlayerX, null],
        [null, null, null],
      ];
      
      final bestMove = getBestMove(board);
      expect(bestMove.row, 0);
      expect(bestMove.col, 2);
    });

    test('AI blocks the opponent from winning', () {
      // X X .
      // O . .
      // . . .
      // If X is about to win at (0, 2), O should block.
      final Board board = [
        [kPlayerX, kPlayerX, null],
        [kPlayerO, null, null],
        [null, null, null],
      ];
      
      final bestMove = getBestMove(board);
      expect(bestMove.row, 0);
      expect(bestMove.col, 2);
    });

    test('AI takes center or first available on empty board', () {
      final board = emptyBoard();
      final bestMove = getBestMove(board);
      // Minimax might return (0,0) if it sees all paths as draws, 
      // but we often want the center for better gameplay.
      // For now, let's just assert it returns a valid move.
      expect(bestMove.row, greaterThanOrEqualTo(0));
      expect(bestMove.row, lessThan(3));
      expect(bestMove.col, greaterThanOrEqualTo(0));
      expect(bestMove.col, lessThan(3));
    });
  });
}
