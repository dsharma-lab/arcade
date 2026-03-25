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

// --- Breakout ---
const kBreakoutBrickCols = 7;
const kBreakoutBrickRows = 5;
const kBreakoutBrickGap = 4.0;
const kBreakoutBrickHeight = 18.0;
const kBreakoutBallRadius = 10.0;
const kBreakoutBallSpeed = 300.0; // pixels per second
const kBreakoutPaddleWidth = 90.0;
const kBreakoutPaddleHeight = 14.0;
const kBreakoutPaddleBottomOffset = 60.0; // distance from bottom of screen
const kBreakoutScorePerBrick = 10;
