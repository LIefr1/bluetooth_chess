import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class ChessPage extends StatefulWidget {
  const ChessPage({Key? key}) : super(key: key);

  @override
  State<ChessPage> createState() => _ChessPageState();
}

class _ChessPageState extends State<ChessPage> {
  ChessBoardController controller = ChessBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess Demo'),
      ),
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Container(
          alignment: Alignment.center,
          height: 120,
          color: Colors.lightBlue,
          child: const Text("New game",
              style: TextStyle(color: Colors.white, fontSize: 24),
              textAlign: TextAlign.justify),
        ),
        Center(
          child: ChessBoard(
            controller: controller,
            boardColor: BoardColor.brown,
            boardOrientation: PlayerColor.white,
          ),
        ),
        Card(
          elevation: 2.0,
          shadowColor: Colors.blue,
          color: Colors.blue,
          child: ValueListenableBuilder<Chess>(
            valueListenable: controller,
            builder: (context, game, _) {
              if (controller.isGameOver()) {
                return AlertDialog(
                  title: Text("Game over by checkmate $_."),
                );
              }
              return Text(
                style: const TextStyle(fontSize: 19, color: Colors.white),
                controller.getSan().fold(
                      'Move List:',
                      (previousValue, element) =>
                          '$previousValue ${element ?? ''}',
                    ),
              );
            },
          ),
        ),
        const SizedBox(height: 100),
      ]),
    );
  }
}
