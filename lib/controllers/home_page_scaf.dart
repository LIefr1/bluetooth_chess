import 'package:flutter/material.dart';
import 'chess_page.dart';

class HomePageLayout extends StatelessWidget {
  const HomePageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle elevBtnStyle = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        minimumSize: const Size(300, 50),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))));
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: elevBtnStyle,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ChessPage(),
              ),
            );
          },
          child: const Text("Play"),
        ),
      ),
    );
  }
}
