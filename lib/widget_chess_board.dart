import 'package:flutter/material.dart';
import 'package:flutter_chess/chess_board_model.dart';
import 'package:flutter_chess/game_bloc.dart';
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

  for (int index = 0; index < 8; index++) {
    int start = index * 8;
    rows.add(TableRow(
        children: data.getRange(start, start + 8).map((item) {
      return WidgetBoardSquare(item);
    }).toList()));
  }

  Widget table = Table(
    defaultColumnWidth: FixedColumnWidth(10),
    border: TableBorder.all(),
    children: rows,
  );

  return AspectRatio(
    aspectRatio: 1,
    child: table,
  );
}
