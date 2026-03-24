# PRD — R4: Monetization

**Release:** 4.0  
**Codename:** Monetization  
**Target Date:** Q4 2026  
**Status:** Future

---

## Goal

Introduce non-intrusive monetization: banner ads shown between games and an
optional one-time In-App Purchase (IAP) to permanently remove ads.

---

## Prerequisites

- R3 fully shipped on Play Store
- App has ≥ 4.0 ★ rating and ≥ 1,000 installs

---

## Guiding Principles

- Ads must never interrupt active gameplay
- IAP to remove ads is a one-time purchase (< $3 USD)
- GDPR/CCPA compliant: consent dialog before showing ads
- No behavioral tracking beyond what AdMob requires

---

## Scope

### In Scope

| # | Feature | Description |
|---|---------|-------------|
| 1 | AdMob Integration | Banner ad shown on game over screen and home screen |
| 2 | Ad Consent | Google UMP consent dialog (GDPR compliance) |
| 3 | Remove Ads IAP | One-time purchase via Google Play Billing to hide all ads |
| 4 | IAP Restore | Restore purchase on new device/reinstall |
| 5 | Privacy Policy Update | Update to reflect advertising data use |

### Out of Scope (R4)

- Rewarded ads
- Subscription model
- Consumable IAP (e.g., coins)
- Cross-platform IAP (iOS handled separately)

---

## User Stories

### Epic 9: Ads

| ID | Story | Priority | Points |
|----|-------|----------|--------|
| #30 | As a user who hasn't purchased "Remove Ads," I see a banner ad on the game over screen | P0 | 5 |
| #31 | As a user, I am shown an ad consent dialog on first launch | P0 | 3 |
| #32 | As a user, I can tap "Remove Ads" to make a one-time purchase | P0 | 5 |
| #33 | As a user who has purchased "Remove Ads," I never see ads | P0 | 3 |
| #34 | As a user, I can restore my "Remove Ads" purchase on a new device | P1 | 3 |

---

## Definition of Done — R4

- [ ] AdMob SDK integrated and banner ads display correctly
- [ ] GDPR consent dialog shown before first ad
- [ ] IAP fully functional end-to-end (purchase + verification)
- [ ] Purchased ad removal persists across app restarts
- [ ] No ads shown to users who have purchased "Remove Ads"
- [ ] Privacy policy updated and linked in app
- [ ] Tested on Android with real Google Play Billing (not test mode)
