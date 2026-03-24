# PRD — R3: Social & Polish

**Release:** 3.0  
**Codename:** Social & Polish  
**Target Date:** Q3 2026 (late)  
**Status:** Planned

---

## Goal

Polish the app for public release: add game statistics, a lifetime high scores screen,
a proper app icon and splash screen, and prepare for Play Store listing.
Add iOS support in this release.

---

## Prerequisites

- R2 fully shipped on Android

---

## Scope

### In Scope

| # | Feature | Description |
|---|---------|-------------|
| 1 | Stats Screen | Games played, wins, win rate per game — persisted locally |
| 2 | All-Time High Scores Screen | View best scores for all games in one place |
| 3 | App Icon | Custom GameVault icon for Android + iOS |
| 4 | Splash Screen | Branded animated splash screen on launch |
| 5 | Sound Effects | Basic SFX: tap, win, lose, game over (can be toggled off) |
| 6 | Settings Screen | Toggle sound on/off, reset high scores |
| 7 | iOS Support | Build and test on iOS Simulator; TestFlight beta |
| 8 | Play Store Listing | Screenshots, description, privacy policy, release APK |

### Out of Scope (R3)

- Ads or in-app purchases
- Online leaderboard

---

## User Stories

### Epic 6: Polish & Assets

| ID | Story | Priority | Points |
|----|-------|----------|--------|
| #21 | As a user, I see a custom GameVault splash screen when opening the app | P0 | 3 |
| #22 | As a user, I see the GameVault icon on my home screen | P0 | 2 |
| #23 | As a user, I hear satisfying sound effects during gameplay (optional toggle) | P1 | 5 |

### Epic 7: Stats & Scores

| ID | Story | Priority | Points |
|----|-------|----------|--------|
| #24 | As a user, I can view my all-time high scores for all games in one screen | P0 | 3 |
| #25 | As a user, I can see my win rate and games played per game type | P1 | 5 |
| #26 | As a user, I can reset my high scores from the settings screen | P1 | 2 |

### Epic 8: Platform & Store

| ID | Story | Priority | Points |
|----|-------|----------|--------|
| #27 | As a developer, I can build a release-signed APK for Play Store upload | P0 | 3 |
| #28 | As a developer, the app has a Play Store listing with screenshots and description | P0 | 5 |
| #29 | As a developer, the app builds and runs on iOS Simulator | P1 | 5 |

---

## Definition of Done — R3

- [ ] App listed on Play Store (internal testing track minimum)
- [ ] App icon and splash screen present on Android
- [ ] High scores screen functional
- [ ] Sound effects implemented with on/off toggle
- [ ] `flutter analyze` and all tests pass
- [ ] Privacy policy URL provided in Play Store listing
