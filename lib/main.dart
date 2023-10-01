import 'package:bluetoth_chess/chess_board.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final ButtonStyle elevBtnStyle = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        minimumSize: const Size(300, 50),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text("Bluetooth Chess"),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            style: elevBtnStyle,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChessBoard(),
                ),
              );
            },
            child: const Text("Play"),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromRGBO(0, 194, 255, 1),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            )
          ],
          selectedItemColor: Colors.white,
        ));
  }
}

class ChessBoard extends StatelessWidget {
  const ChessBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    Chess game = Chess();
    return Scaffold(
      appBar: AppBar(),
      body: GameWidget(game: kDebugMode ? Chess() : game),
    );
  }
}
