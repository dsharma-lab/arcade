# GameVault — Release Roadmap

**Product:** GameVault  
**Platform:** Android (primary), iOS (R3)  
**Last Updated:** March 2026

---

## Timeline

```
Q2 2026        Q3 2026 (early)    Q3 2026 (late)     Q4 2026
   │                 │                  │                 │
   ▼                 ▼                  ▼                 ▼
 R1 MVP          R2 More Games      R3 Social         R4 Monetize
 Tic Tac Toe     Breakout + Snake   Play Store         AdMob + IAP
```

---

## Release Detail

### R1 — MVP (Q2 2026)

**Goal:** Get something playable in the hands of real users.

- App shell with dark arcade theme
- Home screen with game grid
- Tic Tac Toe with unbeatable Minimax AI
- Android APK for local testing

**Success:** Installs and runs on Android without crashes. AI never loses.

---

### R2 — More Games (Q3 2026, early)

**Goal:** Grow the game catalogue and give players a reason to replay.

- Breakout (ball + paddle + bricks)
- Snake (classic, speed-increases)
- High score persistence per game
- Difficulty selection for Tic Tac Toe (Easy/Medium/Hard)

**Success:** 3 fully playable games, high scores save correctly.

---

### R3 — Social & Polish (Q3 2026, late)

**Goal:** Make the app store-ready and add retention hooks.

- Custom app icon and splash screen
- Sound effects with toggle
- Stats screen (win rate per game)
- Play Store listing published (internal/beta track)
- iOS support (TestFlight beta)

**Success:** Live on Play Store. ≥ 4.0 ★ rating from beta testers.

---

### R4 — Monetization (Q4 2026)

**Goal:** Generate revenue sustainably without annoying users.

- AdMob banner ads (shown between games, never during)
- GDPR consent dialog
- "Remove Ads" one-time IAP (< $3 USD)
- Purchase restoration

**Success:** Monetisation live. No significant rating drop from R3.

---

## Future Roadmap (Post-R4, Unplanned)

| Idea | Notes |
|------|-------|
| New games | Tetris-like, Minesweeper, 2048 |
| Global leaderboard | Requires backend (see `docs/api/service-contracts.md`) |
| Daily challenges | One special game mode per day |
| Theme customisation | Unlockable color themes (IAP or achievement-based) |
