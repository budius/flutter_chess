import 'dart:math';

import 'package:chess/chess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess/chess_board_model.dart';
import 'package:flutter_chess/game_bloc.dart';
import 'package:flutter_chess/game_state.dart';
import 'package:flutter_chess/widget_board_square.dart';
import 'package:provider/provider.dart';

class WidgetChessBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = Provider.of(context);
    return StreamBuilder<List<ChessBoardModel>>(
      stream: gameBloc.board,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        } else {
          return _buildBoard(snapshot.data);
        }
      },
    );
  }
}

Widget _buildBoard(List<ChessBoardModel> data) {
  List<TableRow> rows = List();
  List<Widget> row = List();
  for (int i = 0; i < 64; i++) {
    row.add(WidgetBoardSquare(data[i]));
    if (row.length == 8) {
      rows.add(TableRow(children: row));
      row = List();
    }
  }

  return LayoutBuilder(
    builder: (context, constraints) {
      double size = min(constraints.maxHeight, constraints.maxWidth);
      return SizedBox(
          width: size,
          height: size,
          child: Table(
            border: TableBorder.all(),
            children: rows,
          ));
    },
  );
}
