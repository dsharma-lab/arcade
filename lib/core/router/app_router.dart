/// App-wide routing configuration using go_router.
///
/// Add a new GoRoute here when adding a new game screen.
library;

import 'package:go_router/go_router.dart';
import '../../games/home/home_screen.dart';
import '../../games/tictactoe/tictactoe_screen.dart';
import '../../games/breakout/breakout_screen.dart';

/// Route path constants.
class AppRoutes {
  static const home = '/';
  static const tictactoe = '/tictactoe';
  static const breakout = '/breakout';
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.tictactoe,
        builder: (context, state) => const TicTacToeScreen(),
      ),
      GoRoute(
        path: AppRoutes.breakout,
        builder: (context, state) => const BreakoutScreen(),
      ),
      // Add new games here:
      // GoRoute(
      //   path: AppRoutes.snake,
      //   builder: (context, state) => const SnakeScreen(),
      // ),
    ],
  );
}
