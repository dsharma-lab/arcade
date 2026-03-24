# PRD — R2: More Games

**Release:** 2.0  
**Codename:** More Games  
**Target Date:** Q3 2026  
**Status:** Planned

---

## Goal

Add two new playable games (Breakout and Snake) with computer-controlled difficulty
and a basic high score display so players have a reason to replay.

---

## Prerequisites

- R1 MVP fully shipped and stable on Android

---

## Scope

### In Scope

| # | Feature | Description |
|---|---------|-------------|
| 1 | Breakout | Classic ball-and-paddle brick-breaking game, AI-paced difficulty |
| 2 | Snake | Classic Snake with increasing speed; score = length of snake |
| 3 | High Score Display | In-game best score shown on game over screen |
| 4 | Difficulty Selection | Easy / Medium / Hard for Tic Tac Toe (affects AI search depth) |
| 5 | Game Over Screen | Polished overlay: score, high score, Play Again / Home buttons |

### Out of Scope (R2)

- Sound effects
- Leaderboard
- Settings screen
- iOS support

---

## User Stories

### Epic 3: Breakout

| ID | Story | Priority | Points |
|----|-------|----------|--------|
| #9  | As a user, I can see a Breakout game with bricks, a paddle, and a ball | P0 | 5 |
| #10 | As a user, I can move the paddle by dragging left and right | P0 | 3 |
| #11 | As a user, the ball bounces off walls, the paddle, and breaks bricks | P0 | 5 |
| #12 | As a user, the game ends when I miss the ball (game over) or break all bricks (win) | P0 | 3 |
| #13 | As a user, I earn points for each brick I break | P1 | 2 |

### Epic 4: Snake

| ID | Story | Priority | Points |
|----|-------|----------|--------|
| #14 | As a user, I can see a Snake game grid with a snake and food | P0 | 5 |
| #15 | As a user, I can control the snake direction using swipe gestures | P0 | 3 |
| #16 | As a user, the snake grows and speeds up as it eats food | P0 | 3 |
| #17 | As a user, the game ends when the snake hits a wall or itself | P0 | 2 |
| #18 | As a user, my score = number of food items eaten | P1 | 1 |

### Epic 5: Scores & Difficulty

| ID | Story | Priority | Points |
|----|-------|----------|--------|
| #19 | As a user, I can see my all-time high score for each game on the game over screen | P0 | 3 |
| #20 | As a user, I can choose Easy / Medium / Hard difficulty for Tic Tac Toe | P1 | 3 |

---

## Definition of Done — R2

- [ ] All P0 stories complete
- [ ] Breakout and Snake fully playable on Android
- [ ] High scores persist correctly across app restarts
- [ ] `flutter analyze` passes
- [ ] Unit tests for Breakout physics helpers and Snake movement logic
- [ ] Tested on real Android device
