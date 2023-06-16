import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tic_tac/components/board.dart';
import 'package:tic_tac/components/o.dart';
import 'package:tic_tac/components/x.dart';
import 'package:tic_tac/services/board.dart';
import 'package:tic_tac/services/provider.dart';
import 'package:tic_tac/theme/theme.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  final BoardService? boardService = locator<BoardService>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        boardService!.newGame();
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: StreamBuilder<MapEntry<int, int>>(
                stream: boardService!.score$,
                builder: (context, AsyncSnapshot<MapEntry<int, int>> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  final int xScore = snapshot.data!.key;
                  final int oScore = snapshot.data!.value;

                  return SizedBox(
                    // color: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                color: Colors.white,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Material(
                                        elevation: 5,
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        child: Center(
                                            child: Text(
                                          "$xScore",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        )),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    const X(35, 10),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        "player",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[Board()],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                color: Colors.white,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    O(35, MyTheme.green),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        "player",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Material(
                                        elevation: 5,
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        child: Center(
                                            child: Text(
                                          "$oScore",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(),
                              ),
                              IconButton(
                                icon: const Icon(Icons.home),
                                onPressed: () {
                                  boardService!.newGame();
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                },
                                color: Colors.black87,
                                iconSize: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
