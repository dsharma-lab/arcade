# GameVault — Product Requirements Document

**Version:** 1.0  
**Date:** March 2026  
**Author:** Product Team  
**Status:** Approved

---

## 1. Vision

GameVault is a **free, single-player mobile arcade app** — a curated collection of
small, polished mini-games where you always play against a computer AI opponent.
It is the go-to app for a quick, satisfying 5-minute gaming session.

> "Pick it up. Beat the AI. Put it down happy."

---

## 2. Target Users

| Persona | Description |
|---------|-------------|
| Casual Gamer | Ages 15–45, plays in short bursts (commute, waiting) |
| Classic Game Lover | Enjoys timeless games: Tic Tac Toe, Snake, Breakout |
| Competition-Minded | Wants to beat their own high score or outsmart the AI |

---

## 3. Core Principles

1. **Simple to pick up** — no tutorials, no onboarding. Tap → play.
2. **Fast sessions** — every game must be completable in under 5 minutes.
3. **Polished feel** — smooth animations, satisfying feedback, dark arcade aesthetic.
4. **Offline first** — no internet connection ever required to play.
5. **AI, not humans** — all opponents are computer AI. No multiplayer.
6. **Performance** — 60 fps on mid-range Android devices (2021+).

---

## 4. Platform

| Platform | Priority | Notes |
|----------|----------|-------|
| Android | **Primary** (R1) | Minimum SDK: Android 6.0 (API 23) |
| iOS | Secondary (R3) | After Android is stable |

---

## 5. Release Roadmap

| Release | Codename | Focus | Target |
|---------|----------|-------|--------|
| **R1** | MVP | Core app shell + Tic Tac Toe | Q2 2026 |
| **R2** | More Games | Breakout + Snake | Q3 2026 |
| **R3** | Social & Polish | High scores, stats, Play Store | Q3 2026 |
| **R4** | Monetization | AdMob ads, IAP (remove ads) | Q4 2026 |

Detailed PRDs:
- [prd-r1-mvp.md](./prd-r1-mvp.md)
- [prd-r2-more-games.md](./prd-r2-more-games.md)
- [prd-r3-social.md](./prd-r3-social.md)
- [prd-r4-monetization.md](./prd-r4-monetization.md)

---

## 6. Out of Scope (Forever)

- Real-time multiplayer (online or Bluetooth)
- User accounts or login
- Cloud save / sync
- Push notifications
- Social sharing
- In-game chat

---

## 7. Key Metrics

| Metric | R1 Target | R3 Target |
|--------|-----------|-----------|
| Play Store rating | — | ≥ 4.2 ★ |
| Crash-free sessions | ≥ 99% | ≥ 99.5% |
| Frame rate (mid-range Android) | 60 fps | 60 fps |
| App cold start time | < 2s | < 1.5s |
| APK size | < 20 MB | < 30 MB |
