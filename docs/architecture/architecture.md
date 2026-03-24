# Architecture — GameVault

**Version:** 1.0  
**Date:** March 2026

---

## 1. High-Level Overview

GameVault is a **Flutter** mobile application using the **Flame** 2D game engine.
The app has a clean separation between the Flutter widget shell (navigation, menus, settings)
and Flame game components (game loop, rendering, input).

```
┌─────────────────────────────────────────┐
│            Flutter App Shell            │
│  HomeScreen · Router · Theme · Settings │
└───────────────────┬─────────────────────┘
                    │ GameWidget
┌───────────────────▼─────────────────────┐
│              Flame Game World           │
│   Components · Game Loop · Input        │
└───────────────────┬─────────────────────┘
                    │ reads/writes
┌───────────────────▼─────────────────────┐
│            Riverpod State               │
│  GamePhase · Score · Turn · Settings    │
└───────────────────┬─────────────────────┘
                    │ persists
┌───────────────────▼─────────────────────┐
│              Hive Storage               │
│          High Scores · Stats            │
└─────────────────────────────────────────┘
```

---

## 2. Tech Stack

| Layer | Technology | Version | Purpose |
|-------|-----------|---------|---------|
| Language | Dart | 3.x | All app code |
| UI Framework | Flutter | 3.x | App shell, menus, routing |
| Game Engine | Flame | 1.18 | 2D rendering, game loop, input |
| State Mgmt | Riverpod | 2.5 | Cross-widget game state |
| Local Storage | Hive | 2.x | High scores, stats |
| Routing | go_router | 13.x | Declarative navigation |
| Fonts | google_fonts | 6.x | Inter typeface |

---

## 3. Folder Structure

```
lib/
├── main.dart              ← Entry: init Hive, run ProviderScope
├── app.dart               ← MaterialApp.router + theme + router
├── core/
│   ├── theme/
│   │   └── app_theme.dart        ← All colors, text styles
│   ├── router/
│   │   └── app_router.dart       ← All GoRoutes
│   ├── storage/
│   │   └── storage_service.dart  ← Hive read/write
│   └── constants.dart            ← kBoardSize, kGameIds, etc.
├── games/
│   ├── home/
│   │   └── home_screen.dart      ← Game grid
│   ├── tictactoe/
│   │   ├── tictactoe_game.dart   ← FlameGame subclass
│   │   ├── tictactoe_screen.dart ← Widget wrapper
│   │   ├── tictactoe_board.dart  ← Pure board logic
│   │   ├── tictactoe_ai.dart     ← Minimax AI
│   │   └── tictactoe_provider.dart ← Riverpod state
│   ├── breakout/           ← R2
│   └── snake/              ← R2
└── games/shared/
    ├── widgets/
    │   └── game_card.dart
    └── models/             ← GameScore, PlayerResult, etc.

test/                       ← mirrors lib/ structure
```

---

## 4. Flame Game Architecture

Each mini-game follows this pattern:

```
FlameGame subclass (<Game>Game)
├── Components (board grid, pieces, ball, paddle, etc.)
├── onLoad()     ← load assets, add components
├── update(dt)   ← game loop tick (physics, AI timing)
├── render(canvas) ← draw custom graphics
└── onTapDown / onDragUpdate ← handle input
```

The Flame game is embedded in the Flutter widget tree via `GameWidget`:

```dart
GameWidget(game: TicTacToeGame(ref: ref))
```

Riverpod's `WidgetRef` is passed into the Flame game so it can read/write state
without being tightly coupled to Flutter widgets.

---

## 5. State Management Pattern

Riverpod is used for all state that:
- Needs to survive pause/resume
- Needs to be read by both Flutter widgets and Flame game
- Must trigger widget rebuilds (score display, status messages)

Game loop internal state (ball velocity, component positions) lives inside
Flame components — never in Riverpod.

```
TicTacToeNotifier (Riverpod)
├── board: List<List<String?>>
├── phase: GamePhase (playing/playerWon/aiWon/draw)
├── currentTurn: String
└── methods: makeMove(), resetGame()
```

---

## 6. Adding a New Game

1. Create `lib/games/<name>/` folder with 5 files (see `project-rules.md` §11)
2. Register a `GoRoute` in `app_router.dart`
3. Add a `GameCard` entry in `home_screen.dart`
4. Add a game ID constant in `constants.dart`
5. Implement `StorageService.saveHighScore(kGame<Name>Id, score)` on game over
6. Write unit tests for board logic + AI
7. Follow `new-game.md` workflow

---

## 7. Data Flow — Tic Tac Toe Example

```
User taps board cell
    ↓
TicTacToeGame.onTapDown()
    ↓
ref.read(ticTacToeProvider.notifier).makeMove(row, col)
    ↓
TicTacToeNotifier
  - validates move
  - updates board state
  - runs Minimax AI
  - emits new TicTacToeState
    ↓
TicTacToeScreen rebuilds (watches ticTacToeProvider)
  - shows "AI is thinking..." → next turn message
    ↓
TicTacToeGame.render() redraws the updated board
```

---

## 8. Performance Targets

| Metric | Target |
|--------|--------|
| Frame rate | 60 fps sustained on mid-range Android |
| Cold start | < 2 seconds |
| APK size | < 20 MB (R1), < 30 MB (R3) |
| Minimax AI response | < 50 ms for 3×3 board |

---

## 9. Security & Privacy

- No network requests in R1/R2/R3
- No user data collected or transmitted
- All data stored locally in Hive (device-only)
- R4: AdMob requires GDPR consent dialog (UMP SDK)
