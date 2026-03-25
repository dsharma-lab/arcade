/// HomeScreen — the GameVault main screen showing the game grid.
///
/// Displays a card for each available mini-game.
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../shared/widgets/game_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('GameVault'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(Icons.emoji_events, color: AppTheme.kGold),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pick a Game',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Single-player · Beat the AI',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    GameCard(
                      key: const Key('game_card_tictactoe'),
                      title: 'Tic Tac Toe',
                      emoji: '⭕',
                      description: 'Classic 3×3 grid. Beat the unbeatable AI.',
                      onTap: () => context.push(AppRoutes.tictactoe),
                    ),
                    GameCard(
                      key: const Key('game_card_breakout'),
                      title: 'Breakout',
                      emoji: '🧱',
                      description: 'Break all the bricks. Don\'t drop the ball!',
                      onTap: () => context.push(AppRoutes.breakout),
                    ),
                    GameCard(
                      key: const Key('game_card_snake'),
                      title: 'Snake',
                      emoji: '🐍',
                      description: 'Eat, grow, survive.',
                      comingSoon: true,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
