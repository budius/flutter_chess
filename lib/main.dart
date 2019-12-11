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
                child: LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth > constraints.maxHeight) {
                    return Row(
                      children: <Widget>[
                        WidgetChessBoard(),
                        Column(
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                GameBloc gameBloc = Provider.of(context);
                                gameBloc.randomMove();
                              },
                              child: Text("Random Move"),
                            ),
                            RaisedButton(
                              onPressed: () {
                                GameBloc gameBloc = Provider.of(context);
                                gameBloc.restartGame();
                              },
                              child: Text("New Game"),
                            )
                          ],
                        )
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                GameBloc gameBloc = Provider.of(context);
                                gameBloc.randomMove();
                              },
                              child: Text("Random Move"),
                            ),
                            RaisedButton(
                              onPressed: () {
                                GameBloc gameBloc = Provider.of(context);
                                gameBloc.restartGame();
                              },
                              child: Text("New Game"),
                            ),
                          ],
                        ),
                        WidgetChessBoard()
                      ],
                    );
                  }
                }))));
  }
}
