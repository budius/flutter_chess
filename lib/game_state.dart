import 'package:chess/chess.dart';

class GameState {
  Chess _chess = Chess();

  Chess get chess => _chess;

  void restartGame() {
    _chess = Chess();
  }

  void dispose() {
    _chess = null;
  }
}
