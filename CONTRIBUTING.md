# Contributing to GameVault

Thanks for contributing! Please read this guide before submitting a PR.

---

## Git Workflow

- **Never** commit directly to `main` — always use a branch
- Branch naming: `feature/game-name`, `fix/description`, `docs/topic`
- Squash merge only (one commit per PR)
- Every PR must reference an issue: `Closes #XX`

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

| Prefix | Use for |
|--------|---------|
| `feat:` | New game or feature |
| `fix:` | Bug fix |
| `docs:` | Documentation only |
| `refactor:` | Code change, no feature/fix |
| `test:` | Adding tests |
| `chore:` | pubspec, config, tooling |

## Adding a New Game

Follow `.agents/workflows/new-game.md` exactly. Every new game needs:

- `lib/games/<name>/` folder with 5 Dart files
- Route registered in `app_router.dart`
- `GameCard` in `home_screen.dart`
- Unit tests for board logic + AI
- High score saved via `StorageService`

## Code Standards

Before every PR:
```bash
dart format .
flutter analyze        # must be zero errors/warnings
flutter test           # all tests must pass
```

- Follow `project-rules.md` for naming, patterns, and anti-patterns
- If you add a new dependency, justify it in the PR description

## PR Checklist

- [ ] Branch created from latest `main`
- [ ] Code follows project-rules.md conventions
- [ ] `flutter analyze` passes
- [ ] Tests written and passing
- [ ] PR references an issue (`Closes #XX`)
- [ ] Added to `docs/roadmap/epics-stories.md` if a new story
