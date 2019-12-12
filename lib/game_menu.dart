import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chess/game_bloc.dart';
import 'package:provider/provider.dart';

class GameMenu extends StatelessWidget {
  final MenuAlignment alignment;

  const GameMenu({Key key, @required this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = Provider.of(context);
    switch (alignment) {
      case MenuAlignment.horizontal:
        return _horizontal(gameBloc);
      case MenuAlignment.vertical:
        return _vertical(gameBloc);
    }
    return null;
  }

  Widget _vertical(GameBloc gameBloc) {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            gameBloc.randomMove();
          },
          child: Text("Random Move"),
        ),
        RaisedButton(
          onPressed: () {
            gameBloc.restartGame();
          },
          child: Text("New Game"),
        )
      ],
    );
  }

  Widget _horizontal(GameBloc gameBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            gameBloc.randomMove();
          },
          child: Text("Random Move"),
        ),
        RaisedButton(
          onPressed: () {
            gameBloc.restartGame();
          },
          child: Text("New Game"),
        ),
      ],
    );
  }
}

enum MenuAlignment { horizontal, vertical }
