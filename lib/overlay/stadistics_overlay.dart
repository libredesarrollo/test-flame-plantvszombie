import 'package:flutter/material.dart';
import 'package:plantsvszombie/main.dart';

class StatisticsOverlay extends StatefulWidget {
  final MyGame game;
  StatisticsOverlay({Key? key, required this.game}) : super(key: key);

  @override
  State<StatisticsOverlay> createState() => _StatisticsOverlayState();
}

class _StatisticsOverlayState extends State<StatisticsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: SizedBox(
                  height: 10,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    widget.game.paused = !widget.game.paused;
                    setState(() {});
                  },
                  child: Icon(
                      widget.game.paused == true
                          ? Icons.play_arrow
                          : Icons.pause,
                      color: Colors.white,
                      size: 40)),
              GestureDetector(
                  onTap: () {
                    widget.game.reset();
                  },
                  child:
                      const Icon(Icons.replay, color: Colors.white, size: 40)),
            ],
          ),
        ],
      ),
    );
  }
}
