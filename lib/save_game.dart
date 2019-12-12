import 'package:chess/chess.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String KEY_FEN_STATE = "_chess_state_";

class SaveGame {
  static Future<Chess> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(KEY_FEN_STATE)) {
      String fen = prefs.getString(KEY_FEN_STATE);
      return Chess.fromFEN(fen);
    } else {
      return Chess();
    }
  }

  static Future<bool> delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(KEY_FEN_STATE);
  }

  static Future<void> save(Chess chess) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_FEN_STATE, chess.fen);
  }
}
