import 'package:flutter/material.dart';
import 'package:plantsvszombie/main.dart';
import 'package:plantsvszombie/components/plants/plant_component.dart' as pc;

class PlantOverlay extends StatefulWidget {
  final MyGame game;
  PlantOverlay({Key? key, required this.game}) : super(key: key);

  @override
  State<PlantOverlay> createState() => _PlantOverlayState();
}

class _PlantOverlayState extends State<PlantOverlay> {
  double widthPlant1 = 50;

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
                      widget.game.setPlantSelected(pc.Plants.peaschooter);
                    });
                  },
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Opacity(
                        opacity: pc.PlantCost.cost(pc.Plants.peaschooter) <=
                                widget.game.suns
                            ? 1
                            : 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: widget.game.plantSelected ==
                                          pc.Plants.peaschooter
                                      ? 5
                                      : 0,
                                  color: Colors.blueGrey)),
                          child: Image.asset(
                            'assets/images/peashooter.png',
                            width: 50,
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        width: 60,
                        height: 30, //55,
                        color: const Color.fromARGB(80, 255, 255, 255),
                      )
                    ],
                  )),
              const SizedBox(
                width: 5,
              ),
              Opacity(
                opacity: pc.PlantCost.cost(pc.Plants.captus) <= widget.game.suns
                    ? 1
                    : 0.5,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: widget.game.plantSelected == pc.Plants.captus
                              ? 5
                              : 0,
                          color: Colors.blueGrey)),
                  child: GestureDetector(
                      onTap: () {
                        widget.game.setPlantSelected(pc.Plants.captus);
                      },
                      child: Image.asset(
                        'assets/images/cactus.png',
                        width: widthPlant1,
                      )),
                ),
              ),
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
