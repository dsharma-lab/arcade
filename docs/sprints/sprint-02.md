# Sprint 02 — Breakout & Persistence
**Release:** R2 — More Games
**Sprint Goal:** Launch the core Breakout game loop with functional physics and establish system-wide high score persistence.
**Duration:** 2 weeks (Planned)  
**Total Story Points:** 25

## Stories

### [#12] Breakout game scaffold
**Epic:** Breakout  
**Priority:** P0  
**Points:** 5

#### Acceptance Criteria
- [ ] New `lib/games/breakout/` module created
- [ ] `BreakoutGame` (FlameGame) initialized with basic background and borders
- [ ] Game registered in `AppRouter` and reachable from Home Screen
- [ ] Game card on Home Screen updated from "Soon" to active

#### Engineering Tasks
1. Create `lib/games/breakout/breakout_game.dart`
2. Create `lib/games/breakout/breakout_screen.dart` (Flutter wrapper)
3. Implement `Brick`, `Ball`, and `Paddle` Flame components (static)
4. Update `AppRouter` and `home_screen.dart`

#### Definition of Done
- [ ] Code follows Flame/Riverpod standards in `project-rules.md`
- [ ] `flutter analyze` passes
- [ ] Component structure verified in widget tests

---

### [#13] Paddle movement
**Epic:** Breakout  
**Priority:** P0  
**Points:** 3

#### Acceptance Criteria
- [ ] User can drag the paddle left/right using touch
- [ ] Paddle is constrained within the screen boundaries
- [ ] Smooth 60fps movement

#### Engineering Tasks
1. Add `Draggable` or `DragCallbacks` mixin to `Paddle` component
2. Implement `onDragUpdate` to move paddle horizontally
3. Apply clamping to prevent paddle from leaving the screen

---

### [#14] Collision physics
**Epic:** Breakout  
**Priority:** P0  
**Points:** 5

#### Acceptance Criteria
- [ ] Ball moves at constant velocity
- [ ] Ball bounces off left/right/top walls
- [ ] Ball bounces off paddle with physics-based angle adjustment

#### Engineering Tasks
1. Implement physics bounce logic in `Ball.update`
2. Add `CollisionCallbacks` mixin to `Ball`, `Paddle`, and `Brick`
3. Implement `onCollisionStart` for ball-to-paddle logic

---

### [#15–#17] Brick destruction & Win/Loss
**Epic:** Breakout  
**Priority:** P0  
**Points:** 7

#### Acceptance Criteria
- [ ] Bricks are destroyed on ball contact
- [ ] Player earns points per brick
- [ ] Game transitions to Game Over if ball hits floor
- [ ] Game transitions to Win screen if all bricks cleared

#### Engineering Tasks
1. Implement `onCollision` in `Brick` to trigger removal
2. Use Riverpod `scoreProvider` to track points
3. Add floor collision detection
4. Create `GameOverOverlay` in `lib/shared/widgets/`

---

### [#25–#26] Hive High Score Persistence
**Epic:** Scores & Difficulty  
**Priority:** P0  
**Points:** 5

#### Acceptance Criteria
- [ ] `StorageService` updated to handle multiple game IDs
- [ ] High score persists for Breakout and Tic Tac Toe independently
- [ ] High scores are shown on the game-over screen

#### Engineering Tasks
1. Modify `StorageService` to use a Map or dynamic keys in the Hive box
2. Update `lib/shared/models/game_score.dart` if needed
3. Integrate `persistHighScore(gameId, score)` into all game loops

---

## Sprint Risks
| Risk | Likelihood | Mitigation |
|------|-----------|------------|
| Flame Collision Lag | Medium | Use `ScreenHitbox` and optimize bounding boxes for bricks. |
| Ball Stuck in Paddle | Low | Implement a "velocity kick" or position reset on collision. |
| Hive Migration | Low | Current Hive box is empty/simple; no migration scripts needed yet. |

---

## Deferred to Next Sprint
- [#18] Ball speed progression (Wait for base mechanics to be fun)
- [#19–#24] Snake Game implementation
- [#27] Tic Tac Toe Difficulty Selection
