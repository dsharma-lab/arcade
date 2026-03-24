---
name: flutter-game-dev
description: >
  Skills for building GameVault mini-games with Flutter and the Flame 2D game engine.
  Use this skill when: creating a new Flame game component, writing game AI, wiring up
  Riverpod game state, testing game logic, or deploying to Android.
---

# Flutter + Flame Game Development Skill

## Overview

GameVault mini-games are built using:
- **Flutter** for the overall app shell, UI menus, and navigation
- **Flame** for the game loop, rendering, and game components
- **Riverpod** for state that lives outside the Flame game (scores, settings)
- **Hive** for persisting high scores locally

---

## 1. Creating a New Flame Game

Every mini-game follows this structure:

```
lib/games/<game-name>/
  <game>_game.dart       ← FlameGame subclass (the Flame world)
  <game>_screen.dart     ← Flutter Widget wrapping GameWidget
  <game>_board.dart      ← Pure game logic (board state, rules)  
  <game>_ai.dart         ← AI opponent (Minimax or heuristic)
  <game>_provider.dart   ← Riverpod providers (score, game phase)
```

### Minimal FlameGame template

```dart
// lib/games/tictactoe/tictactoe_game.dart
/// Flame game class for Tic Tac Toe. Handles rendering and input.
import 'package:flame/game.dart';
import 'package:flame/events.dart';

class TicTacToeGame extends FlameGame with TapCallbacks {
  @override
  Future<void> onLoad() async {
    // add components here
  }

  @override
  void onTapDown(TapDownEvent event) {
    // handle tap
  }
}
```

### Minimal screen wrapper template

```dart
// lib/games/tictactoe/tictactoe_screen.dart
/// Screen widget that embeds the TicTacToeGame in the Flutter widget tree.
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'tictactoe_game.dart';

class TicTacToeScreen extends StatelessWidget {
  const TicTacToeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: TicTacToeGame()),
    );
  }
}
```

---

## 2. AI Opponent Pattern (Minimax)

For turn-based games (Tic Tac Toe), use Minimax:

```dart
// lib/games/tictactoe/tictactoe_ai.dart
/// Minimax AI for Tic Tac Toe with alpha-beta pruning.

const kAiPlayer = 'O';
const kHumanPlayer = 'X';

/// Returns the best [Position] for the AI to play.
Position getBestMove(List<List<String?>> board) {
  int bestScore = -999;
  Position bestMove = Position(-1, -1);

  for (int row = 0; row < kBoardSize; row++) {
    for (int col = 0; col < kBoardSize; col++) {
      if (board[row][col] == null) {
        board[row][col] = kAiPlayer;
        int score = _minimax(board, 0, false, -999, 999);
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

int _minimax(List<List<String?>> board, int depth, bool isMaximizing,
    int alpha, int beta) {
  final result = checkWinner(board);
  if (result == kAiPlayer) return 10 - depth;
  if (result == kHumanPlayer) return depth - 10;
  if (isBoardFull(board)) return 0;

  if (isMaximizing) {
    int best = -999;
    for (int r = 0; r < kBoardSize; r++) {
      for (int c = 0; c < kBoardSize; c++) {
        if (board[r][c] == null) {
          board[r][c] = kAiPlayer;
          best = max(best, _minimax(board, depth + 1, false, alpha, beta));
          board[r][c] = null;
          alpha = max(alpha, best);
          if (beta <= alpha) break;
        }
      }
    }
    return best;
  } else {
    int best = 999;
    for (int r = 0; r < kBoardSize; r++) {
      for (int c = 0; c < kBoardSize; c++) {
        if (board[r][c] == null) {
          board[r][c] = kHumanPlayer;
          best = min(best, _minimax(board, depth + 1, true, alpha, beta));
          board[r][c] = null;
          beta = min(beta, best);
          if (beta <= alpha) break;
        }
      }
    }
    return best;
  }
}
```

---

## 3. Riverpod State Pattern

```dart
// lib/games/tictactoe/tictactoe_provider.dart
/// Riverpod providers for TicTacToe game state.
import 'package:riverpod_annotation/riverpod_annotation.dart';

enum GamePhase { playing, playerWon, aiWon, draw }

class TicTacToeNotifier extends Notifier<TicTacToeState> {
  @override
  TicTacToeState build() => TicTacToeState.initial();

  void makeMove(int row, int col) { ... }
  void resetGame() { ... }
}
```

---

## 4. Hive Persistence

```dart
// lib/core/storage/storage_service.dart
/// Service for reading/writing game high scores via Hive.
import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const _scoresBoxName = 'high_scores';

  Future<int> getHighScore(String gameId) async {
    final box = await Hive.openBox<int>(_scoresBoxName);
    return box.get(gameId, defaultValue: 0)!;
  }

  Future<void> saveHighScore(String gameId, int score) async {
    final box = await Hive.openBox<int>(_scoresBoxName);
    final current = box.get(gameId, defaultValue: 0)!;
    if (score > current) await box.put(gameId, score);
  }
}
```

---

## 5. Testing Game Logic

```dart
// test/games/tictactoe/tictactoe_ai_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:gamevault/games/tictactoe/tictactoe_ai.dart';

void main() {
  group('TicTacToeAI', () {
    test('blocks human from winning', () {
      final board = [
        ['X', 'X', null],
        [null, 'O', null],
        [null, null, null],
      ];
      final move = getBestMove(board);
      expect(move, equals(Position(0, 2))); // must block!
    });

    test('takes winning move when available', () {
      final board = [
        ['O', 'O', null],
        ['X', 'X', null],
        [null, null, null],
      ];
      final move = getBestMove(board);
      expect(move, equals(Position(0, 2))); // must win!
    });
  });
}
```

---

## 6. Android Deployment Quick Reference

```bash
# Check Flutter setup
flutter doctor -v

# Run on connected Android device (USB debugging on)
flutter devices
flutter run

# Build debug APK
flutter build apk --debug
# APK at: build/app/outputs/flutter-apk/app-debug.apk

# Build release APK (requires signing config)
flutter build apk --release

# Install APK directly to device
adb install build/app/outputs/flutter-apk/app-debug.apk
```

Full deployment guide: `docs/architecture/android-deployment.md`

---

## 7. Common Pitfalls

- ❌ Never call `Flame.images.load()` outside `onLoad()` — assets won't be ready
- ❌ Never update Riverpod state from inside the Flame game loop directly — use `WidgetsBinding.instance.addPostFrameCallback`
- ❌ Don't forget to `await Hive.initFlutter()` in `main()` before `runApp()`
- ✅ Always call `super.onLoad()` first in `FlameGame.onLoad()`
- ✅ Use `overlays` for pause menus and game-over screens in Flame
