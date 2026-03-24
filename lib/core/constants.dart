/// App-wide constants for GameVault.
///
/// All magic numbers and string IDs must be defined here.

// --- Game IDs (used as Hive keys for high scores) ---
const kGameTicTacToeId = 'tictactoe';
const kGameBreakoutId = 'breakout';
const kGameSnakeId = 'snake';

// --- Tic Tac Toe ---
const kBoardSize = 3;
const kPlayerX = 'X';
const kPlayerO = 'O'; // AI plays as O

// --- AI ---
const kMiniMaxDepthLimit = 9; // max for 3x3 board

// --- UI ---
const kCardBorderRadius = 16.0;
const kDefaultPadding = 16.0;
const kLargePadding = 24.0;
