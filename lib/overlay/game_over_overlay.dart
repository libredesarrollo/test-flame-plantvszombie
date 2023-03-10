import 'package:flutter/material.dart';
import 'package:plantsvszombie/main.dart';

class GameOverOverlay extends StatefulWidget {
  final MyGame game;
  GameOverOverlay({Key? key, required this.game}) : super(key: key);

  @override
  State<GameOverOverlay> createState() => _GameOverOverlayState();
}

class _GameOverOverlayState extends State<GameOverOverlay> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        height: 200,
        width: 300,
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          const Text(
            'Game Over',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 200,
            height: 75,
            child: ElevatedButton(
              onPressed: () {
                print('hello');
                //widget.game.colisionMeteors = 50;
                //widget.game.player.reset(dead: true);
                widget.game.paused = true;
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                'Play Again',
                style: TextStyle(fontSize: 28, color: Colors.black),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
