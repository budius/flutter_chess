import 'dart:async';

import 'package:chess/chess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chess/chess_board_model.dart';
import 'package:flutter_chess/main.dart';
import 'package:rxdart/rxdart.dart';

class GameBloc {
  final BehaviorSubject<List<ChessBoardModel>> _board =
      BehaviorSubject<List<ChessBoardModel>>();

  Stream<List<ChessBoardModel>> get board => _board.stream;

  Chess _chess = gameState.chess;

  Timer _timer;

  int selectedIndex = -1;

  bool _random = false;

  GameBloc() {
    //_printMoves();
    _updateBoard();
    if (_random) {
      _timer =
          Timer.periodic(Duration(seconds: 1), (Timer timer) => {randomMove()});
    }
  }

  void _printMoves() {
    var moves = _chess.moves({"asObjects": true});

    moves.forEach((move) {
      debugPrint("Type: ${move.runtimeType} - $move");
    });
  }

  bool _isLegalMove(Move move) {
    List<Move> moves = _chess.moves({"asObjects": true});
    return moves.any((instance) {
      return instance.from == move.from &&
          instance.to == move.to &&
          instance.toAlgebraic == move.toAlgebraic;
    });
  }

  void onTap(ChessBoardModel selected) {
    if (selected.piece != null && selected.piece.color == _chess.turn) {
      if (selectedIndex == selected.index) {
        selectedIndex = -1;
      } else {
        selectedIndex = selected.index;
      }
    } else if (selectedIndex != -1) {
      //move
      Move move =
          _chess.build_move(_chess.board, selectedIndex, selected.index, 0);
      if (_isLegalMove(move)) {
        _chess.move(move);
      }
      selectedIndex = -1;
    }

/*    if (selectedIndex == -1) {
      // select
      if (selected.piece != null && selected.piece.color == _chess.turn) {
        selectedIndex = selected.index;
      }
    } else if (selectedIndex == selected.index) {
      // un-select
      selectedIndex = -1;
    } else {
      //move
      Move move =
          _chess.build_move(_chess.board, selectedIndex, selected.index, 0);
      if (_isLegalMove(move)) {
        _chess.move(move);
      }
      selectedIndex = -1;
    }*/
    _updateBoard();
  }

  void randomMove() {
    if (_chess.game_over) {
      _timer.cancel();
      _timer = null;
      return;
    }

    var moves = _chess.moves();
    moves.shuffle();
    var move = moves[0];
    _chess.move(move);
    _updateBoard();
  }

  void _updateBoard() {
    // https://github.com/davecom/chess.dart/issues/13
    // https://github.com/jhlywa/chess.js/issues/37
    // https://en.wikipedia.org/wiki/Board_representation_(computer_chess)#0x88_method
    List<Piece> input = _chess.board;
    List<ChessBoardModel> output = List();
    int i = 0;
    bool isDarkBackground = false;
    while (i < 128) {
      output.add(
          ChessBoardModel(input[i], i, i == selectedIndex, isDarkBackground));
      i++;
      if (i % 8 == 0) {
        i += 8;
      } else {
        isDarkBackground = !isDarkBackground;
      }
    }
    _board.add(output);
  }

  void onDispose() {
    _timer?.cancel();
    _timer = null;
    _board.close();
  }
}
