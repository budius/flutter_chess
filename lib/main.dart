import 'package:flutter/material.dart';
import 'package:flutter_chess/game_bloc.dart';
import 'package:flutter_chess/game_state.dart';
import 'package:flutter_chess/widget_chess_board.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

GameState gameState = GameState();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'RobotoRegular',
      ),
      home: Scaffold(
          body: Provider(
              builder: (context) => GameBloc(),
              dispose: (context, GameBloc value) => value.onDispose(),
              child: WidgetChessBoard())),
    );
  }
}
