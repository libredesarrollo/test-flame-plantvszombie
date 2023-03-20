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
              _Plant(
                game: widget.game,
                imageAsset: 'assets/images/peashooter.png',
                selected: widget.game.plantSelected == pc.Plants.peaschooter,
                plant: pc.Plants.peaschooter,
              ),
              const SizedBox(
                width: 5,
              ),
              _Plant(
                game: widget.game,
                imageAsset: 'assets/images/cactus.png',
                selected: widget.game.plantSelected == pc.Plants.captus,
                plant: pc.Plants.captus,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Plant extends StatefulWidget {
  final MyGame game;
  final pc.Plants plant;
  final bool selected;
  final String imageAsset;

  const _Plant(
      {super.key,
      required this.game,
      required this.plant,
      required this.imageAsset,
      required this.selected});

  @override
  State<_Plant> createState() => __PlantState();
}

class __PlantState extends State<_Plant> with SingleTickerProviderStateMixin {
  double widthPlant1 = 50;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          //widget.game.paused = !widget.game.paused;
          setState(() {
            _controller.forward();
            widget.game.setPlantSelected(widget.plant);
          });
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Opacity(
              opacity:
                  pc.PlantCost.cost(widget.plant) <= widget.game.suns ? 1 : 0.5,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: widget.selected ? 5 : 0,
                        color: Colors.blueGrey)),
                child: Image.asset(
                  widget.imageAsset,
                  width: 50,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: 60,
                  height: _controller.value * 55, //55,
                  color: const Color.fromARGB(80, 255, 255, 255),
                );
              },
              child: Container(
                width: 60,
                height: 30, //55,
                color: const Color.fromARGB(80, 255, 255, 255),
              ),
            )
          ],
        ));
  }
}
