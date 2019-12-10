import 'package:chess/chess.dart';
import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess/chess_board_model.dart';
import 'package:flutter_chess/game_bloc.dart';
import 'package:provider/provider.dart';

class WidgetBoardSquare extends StatelessWidget {
  final ChessBoardModel _model;

  const WidgetBoardSquare(this._model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (_model.piece == null) {
      content = Container();
    } else {
      content = _getPieceIcon();
    }
    var background;
    if (_model.isSelected) {
      background = Colors.greenAccent;
    } else if (_model.isDarkBackground) {
      background = Colors.black54;
    } else {
      background = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        GameBloc gameBloc = Provider.of(context);
        gameBloc.onTap(_model);
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: DecoratedBox(
          child: content,
          decoration: BoxDecoration(color: background),
        ),
      ),
    );
  }

  Widget _getPieceIcon() {
    switch (_model.piece.type) {
      case Chess.ROOK:
        if (_model.piece.color == Color.WHITE) {
          return WhiteRook();
        } else {
          return BlackRook();
        }
        break;
      case Chess.KNIGHT:
        if (_model.piece.color == Color.WHITE) {
          return WhiteKnight();
        } else {
          return BlackKnight();
        }
        break;
      case Chess.BISHOP:
        if (_model.piece.color == Color.WHITE) {
          return WhiteBishop();
        } else {
          return BlackBishop();
        }
        break;
      case Chess.KING:
        if (_model.piece.color == Color.WHITE) {
          return WhiteKing();
        } else {
          return BlackKing();
        }
        break;
      case Chess.QUEEN:
        if (_model.piece.color == Color.WHITE) {
          return WhiteQueen();
        } else {
          return BlackQueen();
        }
        break;
      case Chess.PAWN:
        if (_model.piece.color == Color.WHITE) {
          return WhitePawn();
        } else {
          return BlackPawn();
        }
        break;
    }
    return null;
  }
}
