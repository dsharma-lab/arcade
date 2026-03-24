# PRD — R1: MVP

**Release:** 1.0 (MVP)  
**Codename:** MVP  
**Target Date:** Q2 2026  
**Status:** Active

---

## Goal

Deliver a working Android app that a real user can download, install, and play.
The MVP contains one fully-polished game (Tic Tac Toe) with an unbeatable AI
and a home screen that previews upcoming games.

---

## Success Criteria

- [ ] App installs and launches on Android 6.0+ without crashes
- [ ] Home screen loads in < 2 seconds on cold start
- [ ] Player can complete a full Tic Tac Toe game (win/lose/draw) in < 2 minutes
- [ ] AI never makes an illegal move
- [ ] AI is unbeatable (Minimax — best possible play always results in draw or AI win)
- [ ] "New Game" resets the board correctly
- [ ] App runs at 60 fps on a mid-range Android device (e.g. Samsung A32)
- [ ] APK size < 20 MB

---

## Scope

### In Scope

| # | Feature | Description |
|---|---------|-------------|
| 1 | App Shell | Flutter app with dark arcade theme, navigation |
| 2 | Home Screen | 2-column game grid with Tic Tac Toe active, others "Coming Soon" |
| 3 | Tic Tac Toe | Full playable game with Minimax AI opponent |
| 4 | Game Over State | Win / Lose / Draw message with "New Game" button |
| 5 | Back Navigation | Navigate back to home from game screen |

### Out of Scope (MVP)

- High score persistence
- Sound/music
- Animations beyond basic rendering
- Settings screen
- iOS support
- Play Store listing

---

## User Stories

### Epic 1: App Shell

| ID | Story | Priority | Points |
|----|-------|----------|--------|
| #1 | As a user, I can open the app and see a home screen with a list of available games | P0 | 3 |
| #2 | As a user, I can tap a game card to launch that game | P0 | 2 |
| #3 | As a user, I can navigate back to the home screen from a game | P0 | 1 |

### Epic 2: Tic Tac Toe

| ID | Story | Priority | Points |
|----|-------|----------|--------|
| #4 | As a user, I can see a 3×3 Tic Tac Toe grid drawn on screen | P0 | 3 |
| #5 | As a user, I can tap a cell to place my mark (X) | P0 | 3 |
| #6 | As a user, the AI automatically plays its move (O) after mine | P0 | 5 |
| #7 | As a user, I can see a message when the game ends (win/lose/draw) | P0 | 3 |
| #8 | As a user, I can tap "New Game" to reset the board and play again | P0 | 2 |

---

## Acceptance Criteria — Tic Tac Toe AI

- Given any board position, the AI must never make an illegal move
- Given a position where the AI can win in one move, it must take it
- Given a position where the player can win in one move, the AI must block it
- Given an empty board, the AI should play center or a corner (optimal Minimax opening)
- The AI must never lose — best outcome for player is a draw

---

## Design Notes

- Theme: dark background (`#0D0D1A`), electric violet accent (`#7C3AED`)
- X pieces: red (`#EF4444`)
- O pieces: green (`#10B981`)
- Grid lines: violet accent
- Font: Inter (via google_fonts)

---

## Dependencies

- Flutter SDK ≥ 3.19
- Flame ≥ 1.18
- Riverpod ≥ 2.5
- Android Studio / ADB for device testing

---

## Definition of Done — R1

- [ ] All P0 stories complete
- [ ] `flutter analyze` passes (zero errors)
- [ ] Unit tests pass for board logic and AI (>80% coverage)
- [ ] Widget test for HomeScreen and TicTacToeScreen
- [ ] Debug APK builds successfully
- [ ] Tested on real Android device (manual)
- [ ] Code reviewed via PR, all PRs reference GitHub issues
