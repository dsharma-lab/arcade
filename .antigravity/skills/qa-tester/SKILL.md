---
name: qa-tester
description: Skill for automated testing (unit, widget, integration) in Flutter
---

# QA Tester Skill

This skill empowers agents to write robust tests for the GameVault project, ensuring high code quality and regression safety.

## 🏆 Goals
- 100% test coverage for game logic (providers, AI, mechanics).
- Widget tests for all critical UI paths (Win/Loss screens, High Score saves).
- Clean, maintainable test code following the `AAA` (Arrange, Act, Assert) pattern.

## 🛠 Tools & Commands
```bash
# Run all tests
flutter test

# Run a specific test file
flutter test test/games/tictactoe/tictactoe_logic_test.dart

# Run with coverage (requires lcov)
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 📝 Patterns

### 1. Unit Testing (Logic)
Focus on pure Dart classes (AI, Board logic).
- Mock dependencies using `mocktail` or `mockito`.
- Test edge cases (full board, empty board, invalid moves).

### 2. Provider Testing (Riverpod)
Test state transitions.
- Use `ProviderContainer` to interact with providers without the widget tree.
- Listen to state changes and verify expected values.

### 3. Widget Testing
- Use `pumpWidget` with `ProviderScope`.
- Use `find.byKey` for stable identifiers (required in `project-rules.md`).
- Simulate user input with `tester.tap()` and `tester.pumpAndSettle()`.

## 🚫 Anti-Patterns
- **No ad-hoc IDs:** Never use `find.text()` for buttons that might change labels (e.g., localisation). Always use `Key`.
- **No untested AI:** Every AI move algorithm MUST be unit tested.
- **No shared state:** Always use a fresh `ProviderContainer` or widget tree for each test.
