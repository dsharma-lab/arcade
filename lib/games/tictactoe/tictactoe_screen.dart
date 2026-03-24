/// TicTacToeScreen — Flutter screen that wraps the Flame TicTacToe game.
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'tictactoe_game.dart';
import 'tictactoe_provider.dart';

class TicTacToeScreen extends ConsumerStatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  ConsumerState<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends ConsumerState<TicTacToeScreen> {
  late final TicTacToeGame _game;

  @override
  void initState() {
    super.initState();
    _game = TicTacToeGame(ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ticTacToeProvider);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        children: [
          // Status banner
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              state.statusMessage,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          // Game canvas
          Expanded(
            child: GameWidget(game: _game),
          ),
          // New game button
          Padding(
            padding: const EdgeInsets.all(24),
            child: ElevatedButton(
              onPressed: () =>
                  ref.read(ticTacToeProvider.notifier).resetGame(),
              child: const Text('New Game'),
            ),
          ),
        ],
      ),
    );
  }
}
