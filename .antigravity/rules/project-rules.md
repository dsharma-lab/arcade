# Project Rules — GameVault

These rules apply to all agent interactions in this project.
Read and follow these before writing any code.

---

## 1. Project Context

GameVault is a **Flutter + Flame** mobile arcade app — a collection of small, fun
single-player games where the opponent is always a computer/AI. The app targets
Android (primary) and iOS (secondary).

Key files to always read before doing any work:
- `docs/architecture/architecture.md` — overall design
- `docs/prd/prd-overview.md` — product vision and release plan
- The relevant `docs/prd/prd-rX-*.md` for the release being worked on
- `pubspec.yaml` — current dependencies

---

## 2. Code Quality & Clarity

- Write code for clarity and maintainability first — avoid clever or complex logic
- Break complex functions into smaller, well-named functions
- One function, one responsibility
- Guard clauses over nested ifs — fail fast, return early
- No magic numbers or strings — use named constants
- Maximum function/method length: ~40 lines. If longer, consider splitting
- No `TODO` comments left in PRs — resolve before merging

**Good:**
```dart
bool isValidMove(int row, int col) {
  return row >= 0 && row < kBoardSize && col >= 0 && col < kBoardSize;
}
```

**Bad:**
```dart
bool check(int r, int c) {
  if (r >= 0) {
    if (r < 3) {
      if (c >= 0) { if (c < 3) { return true; } }
    }
  }
  return false;
}
```

---

## 3. Dart / Flutter Naming

- `camelCase` for functions, variables, local constants
- `PascalCase` for classes, enums, widgets, mixins
- `UPPER_CASE` for top-level/static constants: `const kBoardSize = 3;`
- Prefix constants with `k`: `kDefaultDifficulty`, `kGridSize`
- File names: `snake_case.dart` — e.g., `tic_tac_toe_game.dart`
- Widget files: one widget per file (small helpers can coexist)

---

## 4. Folder Structure

```
lib/
  main.dart              ← app entry, ProviderScope
  app.dart               ← MaterialApp.router, theme, go_router
  core/
    theme/               ← AppTheme, color palette, typography
    router/              ← AppRouter, route constants
    storage/             ← Hive adapters, StorageService
    constants.dart       ← app-wide constants
  games/
    home/                ← HomeScreen (game grid), GameCard widget
    tictactoe/           ← TicTacToe game module
      tictactoe_game.dart        ← Flame FlameGame subclass
      tictactoe_screen.dart      ← Widget wrapping GameWidget
      tictactoe_board.dart       ← Board logic
      tictactoe_ai.dart          ← Minimax AI
      tictactoe_provider.dart    ← Riverpod providers
    breakout/            ← Breakout (R2)
    snake/               ← Snake (R2)
  shared/
    widgets/             ← GameCard, ScoreBoard, PauseOverlay, etc.
    models/              ← GameScore, GameConfig, PlayerResult
```

Never put game logic in screen/widget files.
Always keep AI logic in a dedicated `*_ai.dart` file.
Never put business logic in `main.dart`.

---

## 5. Flutter / Flame Patterns

- Use `FlameGame` subclass for each mini-game
- Use `GameWidget` to embed a Flame game in a Flutter widget tree
- Use `Riverpod` (`StateNotifierProvider`, `Provider`) for all state outside the game loop
- All game state that needs to survive a pause must be in a Riverpod provider, not local to the game
- Use `Hive` for persistence — never `SharedPreferences`
- All colors and text styles come from the `AppTheme` — never hardcode colors

**Good:**
```dart
// In a Component
final scoreNotifier = gameRef.notifier<ScoreNotifier>();
scoreNotifier.increment();

// In a Widget
final score = ref.watch(scoreProvider);
```

---

## 6. Testing

- Widget tests required for all new screens
- Unit tests required for all game logic and AI
- Use `flutter_test` package — never use `print` in tests, use `expect`
- Test file mirrors lib structure: `test/games/tictactoe/tictactoe_ai_test.dart`
- Descriptive names: `test('minimax returns center on empty board', () { ... })`
- Aim for >80% coverage on `core/` and AI files

---

## 7. Documentation

- Dartdoc on all public classes and functions
- Module-level comment at top of every file (one line: what this file does)
- Inline comments for non-obvious game logic only (e.g. Minimax pruning)

```dart
/// Returns the best move for the AI using Minimax with alpha-beta pruning.
///
/// [board] is the current 3×3 board state.
/// Returns a [Position] representing the chosen cell.
Position getBestMove(List<List<CellState>> board) { ... }
```

---

## 8. Linting & Formatting

- Run `flutter analyze` before every commit — zero errors/warnings
- Run `dart format .` before every commit
- `flutter_lints` package is already configured in `analysis_options.yaml`
- No unused imports, no unused variables

---

## 9. Git Workflow

- Never commit directly to `main` — always use feature branches
- Branch naming: `feature/tictactoe-ai`, `fix/score-display`, `docs/architecture`
- Conventional commits:
  - `feat:` new feature or game
  - `fix:` bug fix
  - `docs:` documentation
  - `refactor:` code restructure
  - `test:` adding tests
  - `chore:` pubspec, config, tooling
- Every PR must reference an issue: `Closes #XX`
- Run `flutter analyze && dart format --set-exit-if-changed .` before every PR

---

## 10. Anti-Patterns to Avoid

- ❌ `setState` for global or cross-widget state — use Riverpod
- ❌ Hardcoded colors/sizes in widget files — use AppTheme
- ❌ Game logic inside widget `build()` or `initState()`
- ❌ Direct `Hive.box()` calls outside `StorageService`
- ❌ `print()` in production code — use `debugPrint()` or remove
- ❌ Magic numbers: `if (score > 100)` → use `if (score > kMaxScore)`
- ❌ Deeply nested widget trees — extract into named widget classes
- ❌ Untested AI logic — Minimax must have unit tests

---

## 11. Adding a New Game

Follow the workflow in `.antigravity/workflows/new-game.md`.
Every new game must:
1. Live in its own folder under `lib/games/<game-name>/`
2. Have a Flame `FlameGame` subclass
3. Have a Flutter screen widget wrapping `GameWidget`
4. Be registered in the router (`lib/core/router/`)
5. Be added to the home screen game grid
6. Have unit tests for game logic and AI
7. Persist high score via `StorageService`
## 12. Agent Roles & Skills

The project uses specialized agent skills located in `.antigravity/skills/`:

| Skill | Use for |
| ----- | ------- |
| `flutter-game-dev` | Core game loops, Flame components, Riverpod integration |
| `qa-tester` | Writing unit, widget, and integration tests |
| `architect` | High-level system design, ADRs, and Mermaid diagrams |

### Planning Agent
Use `.antigravity/agents/planning-agent-prompt.md` to start new sprints. The planning agent generates `docs/sprints/sprint-XX.md` based on PRDs and the backlog.
