import 'package:flame/collisions.dart';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import 'package:plantsvszombie/components/plants/cactus_component.dart';
import 'package:plantsvszombie/components/plants/peashooter_component.dart';
import 'package:plantsvszombie/components/plants/plant_component.dart';
import 'package:plantsvszombie/components/plants/sun_component.dart';
import 'package:plantsvszombie/components/zombies/zombie_component.dart';
import 'package:plantsvszombie/components/zombies/zombie_cone_component.dart';
import 'package:plantsvszombie/components/zombies/zombie_door_component.dart';
import 'package:plantsvszombie/maps/tile_map_component.dart';
import 'package:plantsvszombie/helpers/enemies/movements.dart';
import 'package:plantsvszombie/overlay/stadistics_overlay.dart';
import 'package:plantsvszombie/overlay/game_over_overlay.dart';
import 'package:plantsvszombie/overlay/plant_overlay.dart';

class MyGame extends FlameGame
    with
        HasKeyboardHandlerComponents,
        HasCollisionDetection,
        HasTappables /*, TapDetector */ {
  int suns = 50;
  double elapsedTime = 0.0;
  double elapsedTimeSun = 600.0;
  int zombieI = 0;
  late TileMapComponent background;

  Plants plantSelected = Plants.peaschooter;

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

    // add(SkeletonComponent(
    //            mapSize: background.tiledMap.size,
    //           movementTypes: e.movementEnemies,
    //            typeEnemyMovement: e.typeEnemyMovement)..position=Vector2.all(50)));

    //add(ZombieDoorComponent(position: Vector2(1200, 96 - 20)));
    add(ScreenHitbox());

    //return super.onLoad();
  }

  @override
  void update(double dt) {
    if (elapsedTimeSun > 5.0) {
      add(SunComponent(game: this));
      elapsedTimeSun = 0.0;
    }

    elapsedTimeSun += dt;

    if (elapsedTime > 5.0) {
      if (zombieI < enemiesMap1.length) {
        if (enemiesMap1[zombieI].typeEnemy == TypeEnemy.zombie1) {
          add(ZombieConeComponent(
              position: Vector2(background.tiledMap.size.x,
                  enemiesMap1[zombieI].position - alignZombie)));
        } else {
          add(ZombieDoorComponent(
              position: Vector2(background.tiledMap.size.x,
                  enemiesMap1[zombieI].position - alignZombie)));
        }
        zombieI++;
      }
      // print(background.tiledMap.size.x);
      // add(ZombieConeComponent(
      //     position: Vector2(background.tiledMap.size.x, 50)));
      // add(ZombieConeComponent(position: Vector2(50, 50)));
      elapsedTime = 0.0;
    }

    elapsedTime += dt;
    super.update(dt);
  }

  @override
  Color backgroundColor() {
    super.backgroundColor();
    return Colors.purple;
  }

  addSun(int sun) {
    suns += sun;
    print(suns);
  }

  // void addPlant(Offset position) {
  bool addPlant(Vector2 position, Vector2 size) {
    PlantComponent p;
    if (plantSelected == Plants.peaschooter) {
      p = PeashooterComponent(sizeMap: background.tiledMap.size)
        ..position = Vector2(position.x, position.y);
    } else {
      p = CactusComponent(sizeMap: background.tiledMap.size)
        ..position = Vector2(position.x, position.y);
    }

    //final p = CactusComponent(sizeMap: background.tiledMap.size)..position = Vector2(position.x, position.y);
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

  setPlantSelected(Plants plant) {
    plantSelected = plant;
    overlays.remove('Plant');
    overlays.add('Plant');
  }
}

void main() {
  runApp(GameWidget(
    game: MyGame(),
    overlayBuilderMap: {
      'Statistics': (context, MyGame game) {
        return StatisticsOverlay(
          game: game,
        );
      },
      'Plant': (context, MyGame game) {
        return PlantOverlay(
          game: game,
        );
      },
      'GameOver': (context, MyGame game) {
        return GameOverOverlay(
          game: game,
        );
      }
    },
    initialActiveOverlays: const ['Plant'],
  ));
}
