import 'package:flutter/material.dart';
import 'package:plantsvszombie/main.dart';
import 'package:plantsvszombie/components/plants/plant_component.dart'
    as PlantComponent;

class PlantOverlay extends StatefulWidget {
  final MyGame game;
  PlantOverlay({Key? key, required this.game}) : super(key: key);

  @override
  State<PlantOverlay> createState() => _PlantOverlayState();
}

class _PlantOverlayState extends State<PlantOverlay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    //widget.game.paused = !widget.game.paused;
                    setState(() {
                      widget.game
                          .setPlantSelected(PlantComponent.Plants.peaschooter);
                    });
                  },
                  child: Image.asset(
                    'assets/images/peashooter.png',
                    width: 50,
                  )),
              GestureDetector(
                  onTap: () {
                    widget.game.setPlantSelected(PlantComponent.Plants.captus);
                  },
                  child: Image.asset(
                    'assets/images/cactus.png',
                    width: 50,
                  )),
            ],
          ),
          // Row(
          //   children: [
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Icon(
          //       widget.game.colisionMeteors >= 3
          //           ? Icons.favorite_border
          //           : Icons.favorite,
          //       color: Colors.red,
          //     ),
          //     Icon(
          //       widget.game.colisionMeteors >= 2
          //           ? Icons.favorite_border
          //           : Icons.favorite,
          //       color: Colors.red,
          //     ),
          //     Icon(
          //       widget.game.colisionMeteors >= 1
          //           ? Icons.favorite_border
          //           : Icons.favorite,
          //       color: Colors.red,
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
