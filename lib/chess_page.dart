import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'save_game.dart';

showMoves(ChessBoardController controller) {
  return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: ValueListenableBuilder<Chess>(
          valueListenable: controller,
          builder: (context, game, child) {
            if (kDebugMode) {
              print(controller.getFen());
            }
            SaveGame().saveGame(fen: controller.getFen());
            return Text(
              controller.getSan().fold(
                    '',
                    (previousValue, element) =>
                        "$previousValue'\n'${(element ?? '')}",
                  ),
            );
          }));
}

class ChessPage extends StatefulWidget {
  const ChessPage({Key? key}) : super(key: key);

  @override
  State<ChessPage> createState() => _ChessPageStateNewGame();
}

class _ChessPageStateNewGame extends State<ChessPage> {
  _ChessPageStateNewGame();

  ChessBoardController controller = ChessBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ChessBoard(
                controller: controller,
                boardColor: BoardColor.brown,
                boardOrientation: PlayerColor.white,
              ),
            ),
            showMoves(controller),
          ]),
    );
  }
}

class ChessPage2 extends StatefulWidget {
  const ChessPage2({Key? key}) : super(key: key);

  @override
  State<ChessPage2> createState() => _ChessPageStateOldGame();
}

class _ChessPageStateOldGame extends State<ChessPage2> {
  _ChessPageStateOldGame();

  SaveGame oldGame = SaveGame();
  SavedGame? savedGame;
  ChessBoardController controller = ChessBoardController();

  Future<void> innitializeSavedGame() async {
    savedGame = await oldGame.loadGame();
  }

  @override
  void initState() {
    super.initState();
    buildSavedBoard();
  }

  Future<void> buildSavedBoard() async {
    await innitializeSavedGame();
    if (savedGame != null) {
      controller.addListener(() {
        controller.loadFen(savedGame!.moves);
      });
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("No saved data"),
            content:
                const Text("Saved data of your previous game was not found"),
            actions: <Widget>[
              TextButton(
                child: const Text('New Game'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ChessPage()));
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ChessBoard(
                controller: controller,
                boardColor: BoardColor.brown,
                boardOrientation: PlayerColor.white,
              ),
            ),
            showMoves(controller),
          ]),
    );
  }
}
