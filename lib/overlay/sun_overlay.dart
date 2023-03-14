import 'package:flutter/material.dart';
import 'package:plantsvszombie/main.dart';
import 'package:plantsvszombie/components/plants/plant_component.dart'
    as PlantComponent;

class SunOverlay extends StatefulWidget {
  final MyGame game;
  SunOverlay({Key? key, required this.game}) : super(key: key);

  @override
  State<SunOverlay> createState() => _SunOverlayState();
}

class _SunOverlayState extends State<SunOverlay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/SunOverlay.png',
                  width: 50,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.game.suns.toString(),
                style: const TextStyle(
                    fontSize: 30,
                    color: Colors.amber,
                    shadows: [Shadow(color: Colors.black, blurRadius: 5.0)]),
              )
            ],
          ),
        ],
      ),
    );
  }
}
