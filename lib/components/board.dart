import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tic_tac/components/x.dart';
import 'package:tic_tac/services/alert.dart';
import 'package:tic_tac/services/board.dart';
import 'package:tic_tac/services/provider.dart';
import 'package:tic_tac/theme/theme.dart';

import 'o.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  BoardStates createState() => BoardStates();
}

class BoardStates extends State<Board> {
  final BoardService? boardService = locator<BoardService>();
  final AlertService? alertService = locator<AlertService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<
            MapEntry<List<List<String>>, MapEntry<BoardState, String>>>(
        stream: Rx.combineLatest2(
            boardService!.board$!,
            boardService!.boardState$!,
            (dynamic a, dynamic b) => MapEntry(a, b)),
        builder: (context,
            AsyncSnapshot<
                    MapEntry<List<List<String>>, MapEntry<BoardState, String>>>
                snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          final List<List<String>> board = snapshot.data!.key;
          final MapEntry<BoardState, String> state = snapshot.data!.value;

          if (state.key == BoardState.done) {
            boardService!.resetBoard();

            String title = 'Winner';

            if (state.value.isEmpty) {
              title = "Draw";
            }

            Widget body = state.value == 'X'
                ? const X(50, 20)
                : (state.value == "O"
                    ? O(50, MyTheme.green)
                    : Row(
                        children: <Widget>[
                          const X(50, 20),
                          O(50, MyTheme.green)
                        ],
                      ));

            WidgetsBinding.instance.addPostFrameCallback((_) => Alert(
                  context: context,
                  title: title,
                  style: alertService!.resultAlertStyle!,
                  buttons: [],
                  content: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[body]),
                ).show());
          }

          return Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 7.0,
                  spreadRadius: 0.0,
                  color: Color(0x1F000000),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: board
                  .asMap()
                  .map(
                    (i, row) => MapEntry(
                      i,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: row
                            .asMap()
                            .map(
                              (j, item) => MapEntry(
                                j,
                                GestureDetector(
                                  onTap: () {
                                    if (board[i][j] != ' ') return;
                                    boardService!.newMove(i, j);
                                  },
                                  child: _buildBox(i, j, item),
                                ),
                              ),
                            )
                            .values
                            .toList(),
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          );
        });
  }

  Widget _buildBox(int i, int j, item) {
    BoxBorder border = const Border();
    BorderSide borderStyle = const BorderSide(width: 1, color: Colors.black26);
    double height = 80;
    double width = 60;
    if (j == 1) {
      border = Border(right: borderStyle, left: borderStyle);
      height = width = 80;
    }
    if (i == 1) {
      border = Border(top: borderStyle, bottom: borderStyle);
    }
    if (i == 1 && j == 1) {
      border = Border(
          top: borderStyle,
          bottom: borderStyle,
          left: borderStyle,
          right: borderStyle);
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: border,
      ),
      height: height,
      width: width,
      child: Center(
        child: item == ' '
            ? null
            : item == 'X'
                ? const X(50, 13)
                : O(50, MyTheme.green),
      ),
    );
  }
}
