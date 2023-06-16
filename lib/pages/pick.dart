import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac/components/btn.dart';
import 'package:tic_tac/components/o.dart';
import 'package:tic_tac/components/x.dart';
import 'package:tic_tac/services/board.dart';
import 'package:tic_tac/services/provider.dart';
import 'package:tic_tac/services/sound.dart';
import 'package:tic_tac/theme/theme.dart';

import 'game.dart';

class PickPage extends StatefulWidget {
  const PickPage({super.key});

  @override
  PickPageState createState() => PickPageState();
}

class PickPageState extends State<PickPage> {
  final BoardService? boardService = locator<BoardService>();
  final SoundService? soundService = locator<SoundService>();

  String? groupValue = 'X';
  void setGroupvalue(value) {
    setState(() {
      groupValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text(
                "Pic Your Side",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => setGroupvalue('X'),
                        child: const X(100, 20),
                      ),
                      Radio(
                        onChanged: (dynamic e) => setGroupvalue(e),
                        activeColor: MyTheme.orange,
                        value: 'X',
                        groupValue: groupValue,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "First",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => setGroupvalue("O"),
                        child: O(100, MyTheme.green),
                      ),
                      Radio(
                        onChanged: (dynamic e) => setGroupvalue(e),
                        activeColor: MyTheme.orange,
                        value: 'O',
                        groupValue: groupValue,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Second",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Btn(
                onTap: () {
                  boardService!.resetBoard();
                  boardService!.setStart(groupValue);
                  if (groupValue == 'O') {
                    boardService!.player$!.add("X");
                    boardService!.botMove();
                  }
                  soundService!.playSound('click');

                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const GamePage(),
                    ),
                  );
                },
                height: 40,
                width: 250,
                borderRadius: 200,
                gradient: [MyTheme.orange, MyTheme.red],
                child: Text(
                  "continue".toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
