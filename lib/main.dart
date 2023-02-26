import 'package:flame/collisions.dart';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:plantsvszombie/components/plants/cactus_component.dart';
import 'package:plantsvszombie/components/zombies/zombie_cone_component.dart';
import 'package:plantsvszombie/components/zombies/zombie_door_component.dart';
import 'package:plantsvszombie/maps/tile_map_component.dart';

class MyGame extends FlameGame
    with
        HasKeyboardHandlerComponents,
        HasCollisionDetection,
        HasTappables /*, TapDetector */ {
  double elapsedTime = 0.0;
  late TileMapComponent background;

  @override
  Future<void>? onLoad() {
    background = TileMapComponent(game: this);
    add(background);

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
    add(ZombieConeComponent(position: Vector2(1200, 48 - 20)));
    add(ZombieDoorComponent(position: Vector2(1200, 96 - 20)));
    add(ScreenHitbox());

    //return super.onLoad();
  }

  @override
  void update(double dt) {
    if (elapsedTime > 3.0) {
      print(background.tiledMap.size.x);
      add(ZombieConeComponent(
          position: Vector2(background.tiledMap.size.x, 50)));
      // add(ZombieConeComponent(position: Vector2(50, 50)));
      elapsedTime = 0.0;
    }

    //elapsedTime += dt;
    super.update(dt);
  }

  @override
  Color backgroundColor() {
    super.backgroundColor();
    return Colors.purple;
  }

  // void addPlant(Offset position) {
  bool addPlant(Vector2 position, Vector2 size) {
    //final p = PeashooterComponent()..position = Vector2(position.x, position.y);
    final p = CactusComponent()..position = Vector2(position.x, position.y);
    final fac = size.y / p.size.y; //25 50 = 2
    p.size *= fac;
    add(p);

    return true;
    // add(CactusComponent()..position = Vector2(position.x, position.y));
  }
  // @override
  // bool onTapDown(TapDownInfo info) {
  //   add(PeashooterComponent()
  //     ..position =
  //         Vector2(info.raw.localPosition.dx, info.raw.localPosition.dy));
  //   return true;
  // }
}

void main() {
  runApp(GameWidget(
    game: MyGame(),
  ));
}
