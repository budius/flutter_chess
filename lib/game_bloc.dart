import 'dart:async';

import 'package:chess/chess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chess/chess_board_model.dart';
import 'package:flutter_chess/save_game.dart';
import 'package:rxdart/rxdart.dart';

class GameBloc {
  final BehaviorSubject<List<ChessBoardModel>> _board =
      BehaviorSubject<List<ChessBoardModel>>();

  Stream<List<ChessBoardModel>> get board => _board.stream;

  Completer<void> _loadCompleter = Completer();

  Chess _chess;

  int selectedIndex = -1;

  GameBloc() {
    _init();
  }

  void _awaitIsLoaded() async {
    await _loadCompleter.future;
  }

  void _init() async {
    _chess = await SaveGame.load();
    _loadCompleter.complete();
    _updateBoard();
  }

  void _printMoves() async {
    _awaitIsLoaded();
    var moves = _chess.moves({"asObjects": true});

    moves.forEach((move) {
      debugPrint("Type: ${move.runtimeType} - $move");
    });
  }

  void onTap(ChessBoardModel selected) async {
    if (selected.piece != null && selected.piece.color == _chess.turn) {
      if (selectedIndex == selected.index) {
        // remove selection
        selectedIndex = -1;
      } else {
        // select
        selectedIndex = selected.index;
      }
    } else if (selectedIndex != -1) {
      //move
      Move requestedMove =
          _chess.build_move(_chess.board, selectedIndex, selected.index, 0);
      if (_chess.isLegalMove(requestedMove)) {
        _chess.move(requestedMove);
        await SaveGame.save(_chess);
      }
      selectedIndex = -1;
    }
    _updateBoard();
  }

  void randomMove() async {
    _awaitIsLoaded();
    var moves = _chess.moves();
    moves.shuffle();
    var move = moves[0];
    _chess.move(move);
    await SaveGame.save(_chess);
    _updateBoard();
  }

  void restartGame() async {
    _awaitIsLoaded();
    await SaveGame.delete();
    _chess = Chess();
    _updateBoard();
  }

  void _updateBoard() async {
    _awaitIsLoaded();
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
    _board.close();
  }
}

extension on Chess {
  bool isLegalMove(Move move) {
    List<Move> moves = this.moves({"asObjects": true});
    return moves.any((instance) {
      return instance.from == move.from &&
          instance.to == move.to &&
          instance.toAlgebraic == move.toAlgebraic;
    });
  }
}
