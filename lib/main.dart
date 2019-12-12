import 'package:flutter/material.dart';
import 'package:flutter_chess/game_bloc.dart';
import 'package:flutter_chess/game_menu.dart';
import 'package:flutter_chess/widget_chess_board.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

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
                    return buildHorizontal(context);
                  } else {
                    return buildVertical(context);
                  }
                }))));
  }

  Widget buildHorizontal(BuildContext context) {
    return Row(
      children: <Widget>[
        WidgetChessBoard(),
        GameMenu(
          alignment: MenuAlignment.vertical,
        ),
      ],
    );
  }

  Widget buildVertical(BuildContext context) {
    return Column(
      children: <Widget>[
        GameMenu(
          alignment: MenuAlignment.horizontal,
        ),
        WidgetChessBoard(),
      ],
    );
  }
}
