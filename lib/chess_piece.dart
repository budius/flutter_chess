class ChessPiece {
  final int id;
  final ChessPieceType type;
  final ChessPiecePlayer player;
  String _pieceName;

  String get pieceName => _pieceName;

  ChessPiece(this.id, this.type, this.player) {
    switch (type) {
      case ChessPieceType.KING:
        _pieceName = "K";
        break;
      case ChessPieceType.QUEEN:
        _pieceName = "Q";
        break;
      case ChessPieceType.ROOKS:
        _pieceName = "R";
        break;
      case ChessPieceType.BISHOP:
        _pieceName = "B";
        break;
      case ChessPieceType.KNIGHT:
        _pieceName = "N";
        break;
      case ChessPieceType.PAWN:
        _pieceName = "";
        break;
    }
  }
}

/// King, Queen, Knight, etc
enum ChessPieceType {
  KING,
  QUEEN,
  ROOKS, // tower
  BISHOP,
  KNIGHT,
  PAWN
}

/// Avoiding calling it "colors"
/// because putting white and black against each other is racist
enum ChessPiecePlayer { PLAYER_A, PLAYER_B }
