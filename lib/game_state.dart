import 'dart:async';

import 'package:chess/chess.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String KEY_FEN_STATE = "_chess_state_";

class GameState {
  SharedPreferences _prefs;
  Completer<void> _loadingComplete = Completer();
  Chess _chess;

  Future<Chess> get chess async {
    await _loadingComplete.future;
    return _chess;
  }

  GameState() {
    _init();
  }

  void _init() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey(KEY_FEN_STATE)) {
      String fen = _prefs.getString(KEY_FEN_STATE);
      _chess = Chess.fromFEN(fen);
    } else {
      _chess = Chess();
    }
    _loadingComplete.complete();
  }

  Future<void> save() async {
    await _loadingComplete.future;
    String fen = _chess.fen;
    await _prefs.setString(KEY_FEN_STATE, fen);
  }

  Future<void> restartGame() async {
    await _loadingComplete.future;
    await _prefs.remove(KEY_FEN_STATE);
    _chess = Chess();
  }
}
