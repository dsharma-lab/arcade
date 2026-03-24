# Service Contracts — GameVault

**Version:** 0.1 (Draft)  
**Status:** Future (R4+)  
**Note:** All R1–R3 features are fully offline — no APIs needed.
These contracts are defined ahead of time so a backend can be built independently.

---

## 1. Overview

These APIs will be used for **R4+ features** (global leaderboard, cloud sync).
In R1–R3 all data is stored locally via Hive on-device.

Base URL (future): `https://api.gamevault.app/v1`

All endpoints:
- Return `application/json`
- Use HTTP status codes conventionally
- Require `Authorization: Bearer <token>` header (R4+)

---

## 2. Leaderboard Service

### GET /leaderboard/{gameId}

Returns the global top-N high scores for a game.

**Path Params:**
- `gameId` (string) — one of: `tictactoe`, `breakout`, `snake`

**Query Params:**
- `limit` (int, default 10, max 100) — number of entries to return

**Response 200:**
```json
{
  "gameId": "breakout",
  "entries": [
    {
      "rank": 1,
      "displayName": "Player123",
      "score": 4200,
      "achievedAt": "2026-08-15T10:22:00Z"
    },
    {
      "rank": 2,
      "displayName": "ArcadeKing",
      "score": 3900,
      "achievedAt": "2026-08-14T19:05:00Z"
    }
  ]
}
```

---

### POST /leaderboard/{gameId}/submit

Submit a new score for a game.

**Body:**
```json
{
  "score": 4200,
  "deviceId": "anon-uuid-v4"
}
```

**Response 201:**
```json
{
  "rank": 1,
  "isNewPersonalBest": true,
  "message": "New high score!"
}
```

**Response 400:**
```json
{
  "error": "INVALID_SCORE",
  "message": "Score must be a non-negative integer."
}
```

---

## 3. Error Codes

| Code | HTTP Status | Meaning |
|------|-------------|---------|
| `INVALID_GAME_ID` | 400 | `gameId` not in allowed list |
| `INVALID_SCORE` | 400 | Score is negative or not an integer |
| `RATE_LIMITED` | 429 | Too many submissions in short window |
| `SERVER_ERROR` | 500 | Internal server error |

---

## 4. Data Retention

- Leaderboard scores are kept indefinitely
- Anonymous device IDs are not linked to personal data
- GDPR: users can request score deletion via in-app support email

---

## 5. Implementation Notes (for Backend Team)

- Stack: any (FastAPI / Node.js / etc.)
- Database: PostgreSQL recommended (indexed on `gameId`, `score DESC`)
- Rate limiting: max 5 score submissions per device per hour per game
- Anti-cheat: scores above theoretical maximums per game should be rejected
  - Tic Tac Toe: no score, win/loss only
  - Breakout: theoretical max based on brick count × points per brick
  - Snake: theoretical max based on grid size
