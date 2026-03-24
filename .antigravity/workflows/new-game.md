---
description: How to add a new mini-game to GameVault
---

# Workflow: Add a New Mini-Game to GameVault

Follow these steps to add a new mini-game to GameVault. Every step is required.

---

## 1. Create the game folder

```bash
mkdir -p lib/games/<game-name>
```

Create these files inside the folder:
- `<game>_game.dart` — Flame `FlameGame` subclass
- `<game>_screen.dart` — Flutter `Widget` wrapping `GameWidget`
- `<game>_board.dart` — Pure game logic (rules, board state)
- `<game>_ai.dart` — AI opponent logic
- `<game>_provider.dart` — Riverpod providers (score, game phase)

Follow the templates in `.agents/skills/flutter-game-dev/SKILL.md`.

## 2. Define a game ID constant

In `lib/core/constants.dart`, add:
```dart
const kGame<Name>Id = '<game-name>';
```

## 3. Register the route

In `lib/core/router/app_router.dart`, add a `GoRoute` for the new game screen.

## 4. Add to the home screen grid

In `lib/games/home/home_screen.dart`, add a `GameCard` entry with:
- Game title
- Icon/thumbnail asset
- Route path

## 5. Add asset (if needed)

Add any sprites/assets to `assets/images/<game-name>/` and register in `pubspec.yaml`.

## 6. Write tests

Create:
- `test/games/<game-name>/<game>_board_test.dart` — unit tests for game logic
- `test/games/<game-name>/<game>_ai_test.dart` — unit tests for AI
- `test/games/<game-name>/<game>_screen_test.dart` — widget test for screen

## 7. Persist high score

Call `StorageService.saveHighScore(kGame<Name>Id, score)` on game over.

## 8. Run verification

```bash
flutter analyze
dart format --set-exit-if-changed .
flutter test
flutter build apk --debug
```

## 9. Create PR

- Branch: `feature/<game-name>-game`
- PR title: `feat: add <Game Name> mini-game`
- Reference the GitHub issue: `Closes #XX`
