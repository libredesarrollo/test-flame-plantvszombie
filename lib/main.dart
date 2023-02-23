import 'package:flame/collisions.dart';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:plantsvszombie/components/plants/cactus_component.dart';
import 'package:plantsvszombie/components/plants/peashooter_component.dart';
import 'package:plantsvszombie/maps/tile_map_component.dart';

class MyGame extends FlameGame
    with
        HasKeyboardHandlerComponents,
        HasCollisionDetection,
        HasTappables /*, TapDetector */ {
  @override
  Future<void>? onLoad() {
    var background = TileMapComponent(game: this);

    add(background);

    // add(PeashooterComponent());
    // add(CactusComponent());
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

  // void addPlant(Offset position) {
  void addPlant(Vector2 position, Vector2 size) {
    final p = PeashooterComponent()..position = Vector2(position.x, position.y);

    final fac = size.y / p.size.y; //25 50 = 2
    //p.size.y = size.y;

    p.size *= fac;

    print(fac);

    // p.position = position - p.size;
    add(p);
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
