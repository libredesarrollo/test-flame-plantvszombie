import 'package:flame/collisions.dart';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:plantsvszombie/components/plant_component.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  @override
  Future<void>? onLoad() {
    add(PlantComponent());
    // var background = TileMapComponent();
    // add(background);

    // background.loaded.then(
    //   (value) {
    //     player = PlayerComponent(
    //         mapSize: background.tiledMap.size,
    //         game: this,
    //         posPlayer: background.posPlayer);
    //     add(player);
    //     camera.followComponent(player,
    //         worldBounds: Rect.fromLTRB(
    //             0, 0, background.tiledMap.size.x, background.tiledMap.size.y));
    //     add(ZombieComponent(mapSize: background.tiledMap.size));
    //   },
    // );

    add(ScreenHitbox());

    //return super.onLoad();
  }

  @override
  Color backgroundColor() {
    super.backgroundColor();
    return Colors.purple;
  }
}

void main() {
  runApp(GameWidget(
    game: MyGame(),
  ));
}
