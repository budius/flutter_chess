import 'package:chess/chess.dart';

class ChessBoardModel {

  final Piece piece;
  final int index;
  final bool isSelected;
  final bool isDarkBackground;

  ChessBoardModel(
      this.piece, this.index, this.isSelected, this.isDarkBackground);
}
