/// Riverpod state management for TicTacToe game.
///
/// Manages board state, turns, AI moves, and game phase.
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import 'tictactoe_ai.dart';
import 'tictactoe_board.dart';

// --- State ---

enum GamePhase { playing, playerWon, aiWon, draw }

class TicTacToeState {
  const TicTacToeState({
    required this.board,
    required this.phase,
    required this.currentTurn,
  });

  factory TicTacToeState.initial() => TicTacToeState(
        board: emptyBoard(),
        phase: GamePhase.playing,
        currentTurn: kPlayerX,
      );

  final Board board;
  final GamePhase phase;
  final String currentTurn;

  String get statusMessage => switch (phase) {
        GamePhase.playing =>
          currentTurn == kPlayerX ? 'Your turn (X)' : 'AI is thinking…',
        GamePhase.playerWon => '🎉 You won!',
        GamePhase.aiWon => '🤖 AI wins!',
        GamePhase.draw => '🤝 It\'s a draw!',
      };

  TicTacToeState copyWith({
    Board? board,
    GamePhase? phase,
    String? currentTurn,
  }) =>
      TicTacToeState(
        board: board ?? this.board,
        phase: phase ?? this.phase,
        currentTurn: currentTurn ?? this.currentTurn,
      );
}

// --- Notifier ---

class TicTacToeNotifier extends Notifier<TicTacToeState> {
  @override
  TicTacToeState build() => TicTacToeState.initial();

  /// Applies the player's move at [row], [col], then triggers AI move.
  void makeMove(int row, int col) {
    if (state.phase != GamePhase.playing) return;
    if (state.board[row][col] != null) return;

    // Apply player move
    final newBoard = _copyBoard(state.board);
    newBoard[row][col] = kPlayerX;

    final result = checkWinner(newBoard);
    if (result != null) {
      state = state.copyWith(
        board: newBoard,
        phase: _phaseFromResult(result),
      );
      return;
    }

    // Trigger AI move
    state = state.copyWith(board: newBoard, currentTurn: kPlayerO);
    _doAiMove(newBoard);
  }

  void _doAiMove(Board board) {
    final move = getBestMove(board);
    final newBoard = _copyBoard(board);
    newBoard[move.row][move.col] = kPlayerO;

    final result = checkWinner(newBoard);
    state = state.copyWith(
      board: newBoard,
      phase: result != null ? _phaseFromResult(result) : GamePhase.playing,
      currentTurn: kPlayerX,
    );
  }

  void resetGame() {
    state = TicTacToeState.initial();
  }

  Board _copyBoard(Board board) =>
      board.map((row) => List<String?>.from(row)).toList();

  GamePhase _phaseFromResult(String result) => switch (result) {
        kPlayerX => GamePhase.playerWon,
        kPlayerO => GamePhase.aiWon,
        _ => GamePhase.draw,
      };
}

// --- Provider ---

final ticTacToeProvider =
    NotifierProvider<TicTacToeNotifier, TicTacToeState>(
  TicTacToeNotifier.new,
);
