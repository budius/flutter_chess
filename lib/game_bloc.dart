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

  Future<Chess> _chess() async {
    return await gameState.chess;
  }

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

  void _printMoves() async {
    var moves = (await _chess()).moves({"asObjects": true});

    moves.forEach((move) {
      debugPrint("Type: ${move.runtimeType} - $move");
    });
  }

  void onTap(ChessBoardModel selected) async {
    Chess chess = await _chess();
    if (selected.piece != null && selected.piece.color == chess.turn) {
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
          chess.build_move(chess.board, selectedIndex, selected.index, 0);
      if (chess.isLegalMove(requestedMove)) {
        chess.move(requestedMove);
        await gameState.save();
      }
      selectedIndex = -1;
    }
    _updateBoard();
  }

  void randomMove() async {
    Chess chess = await _chess();
    if (chess.game_over) {
      _timer.cancel();
      _timer = null;
      return;
    }

    var moves = chess.moves();
    moves.shuffle();
    var move = moves[0];
    chess.move(move);
    await gameState.save();
    _updateBoard();
  }

  void restartGame() async {
    await gameState.restartGame();
    _updateBoard();
  }

  void _updateBoard() async {
    // https://github.com/davecom/chess.dart/issues/13
    // https://github.com/jhlywa/chess.js/issues/37
    // https://en.wikipedia.org/wiki/Board_representation_(computer_chess)#0x88_method
    List<Piece> input = (await _chess()).board;
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
