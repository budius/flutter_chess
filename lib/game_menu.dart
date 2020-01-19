import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chess/game_bloc.dart';
import 'package:flutter_chess/shadow_button.dart';
import 'package:provider/provider.dart';

class GameMenu extends StatelessWidget {
  final MenuAlignment alignment;

  const GameMenu({Key key, @required this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = Provider.of(context);
    switch (alignment) {
      case MenuAlignment.horizontal:
        return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: widgets(gameBloc));
      case MenuAlignment.vertical:
        return Column(
          children: widgets(gameBloc),
        );
    }
    return null;
  }

  List<Widget> widgets(GameBloc gameBloc) {
    return <Widget>[
      ShadowButton(
        onPressed: gameBloc.randomMove,
        icon: Icons.shuffle,
        text: 'Random Move',
      ),
      ShadowButton(
        onPressed: gameBloc.restartGame,
        icon: Icons.clear_all,
        text: 'New Game',
      )
    ];
  }
}

enum MenuAlignment { horizontal, vertical }
