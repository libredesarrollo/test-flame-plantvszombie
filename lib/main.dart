import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:flame/game.dart';
import 'package:plantsvszombie/components/plants/cactus_component.dart';
import 'package:plantsvszombie/components/plants/peashooter_component.dart';
import 'package:plantsvszombie/components/plants/plant_component.dart';
import 'package:plantsvszombie/components/plants/sun_component.dart';
import 'package:plantsvszombie/components/zombies/zombie_component.dart';
import 'package:plantsvszombie/components/zombies/zombie_cone_component.dart';
import 'package:plantsvszombie/components/zombies/zombie_door_component.dart';
import 'package:plantsvszombie/helpers/enemies/movements.dart';
import 'package:plantsvszombie/maps/tile_map_component.dart';
import 'package:plantsvszombie/overlay/plant_overlay.dart';
import 'package:plantsvszombie/overlay/stadistics_overlay.dart';
import 'package:plantsvszombie/overlay/sun_overlay.dart';
import 'package:plantsvszombie/overlay/main_menu_overlay.dart';

class MyGame extends FlameGame
    with HasCollisionDetection, HasTappables /*TapDetector*/ {
  late TileMapComponent background;

  bool resetGame = false;
  double elapsepTime = 0;
  double elapsepTimeSun = 0;

  int zombieI = 0;
  int suns = 50;

  Plants plantSelected = Plants.peashooter;

  late AudioPlayer audioWalk;

  bool endGame = false;
  //Plants? plantAddedInMap;

  final List<bool> plantsAddedInMap = [false, false];

  void checkEndGame() {
    if (zombieI >= enemiesMap1.length - 1) {
      // revisamos si todos los zombies del mapa actual fueron cargados en el mapa
      if (countEnemiesInMap == 0) {
        // revisamos si todos los zombies fueron vencidos
        print('fin del juego');
      }
    }
  }

  @override
  void onLoad() {
    plantsAddedInMap.add(true);

    background = TileMapComponent(game: this);
    add(background);

    // add(ZombieConeComponent(position: Vector2(1200,48)));
    // add(ZombieDoorComponent(position: Vector2(1200,96)));

    super.onLoad();
  }

  bool addPlant(Vector2 position, Vector2 sizeSeed) {
    late PlantComponent p;

    if (plantsAddedInMap[plantSelected.index]) {
      // no agregar la planta seleccionada
      return false;
    }

    if (!removeSuns(PlantCost.cost(plantSelected))) {
      return false;
    }

    plantsAddedInMap[plantSelected.index] = true;
    if (plantSelected == Plants.peashooter) {
      p = PeashooterComponent(sizeMap: background.tiledMap.size)
        ..position = Vector2(position.x, position.y);
    } else {
      p = CactusComponent(sizeMap: background.tiledMap.size)
        ..position = Vector2(position.x, position.y);
    }

    var fac = sizeSeed.y / p.size.y;
    p.size *= fac;
    add(p);

    return true;
  }

  setPlantSelected(Plants plant) {
    plantSelected = plant;
    _refreshOverlayPlant();
  }

  _refreshOverlayPlant() {
    overlays.remove('Plant');
    overlays.add('Plant');
  }

  _refreshOverlaySun() {
    overlays.remove('Sun');
    overlays.add('Sun');
  }

  addSuns(int sun) {
    suns += sun;
    _refreshOverlaySun();
  }

  reset() {
    resetGame = true;
    Timer(const Duration(milliseconds: 300), () {
      init();
    });
  }

  init() {
    suns = 50;
    zombieI = 0;
    resetGame = false;
    endGame = false;
    _refreshOverlaySun();
    _refreshOverlayPlant();
  }

  bool removeSuns(int sun) {
    if (suns - sun >= 0) {
      suns -= sun;
      _refreshOverlaySun();
      return true;
    }

    return false;
  }

  @override
  Color backgroundColor() {
    super.backgroundColor();

    return Colors.purple;
  }

  _zombieWalkAudio() {
    FlameAudio.loop(
      'zombies_many',
      volume: .5,
    ).then((audioPlayer) {
      audioWalk = audioPlayer;
    });
  }

  @override
  void update(double dt) {
    if (elapsepTimeSun > 2) {
      elapsepTimeSun = 0;
      add(SunComponent(/*game: this*/));
    }

    checkEndGame();

    elapsepTimeSun += dt;

    if (elapsepTime > 3.0) {
      if (zombieI < enemiesMap1.length) {
        if (zombieI == 0) _zombieWalkAudio();

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
        // if (zombieI > 3) resetGame = true;
      }
      elapsepTime = 0;
    }
    elapsepTime += dt;

    super.update(dt);
  }

  // @override
  // void onTapDown(TapDownInfo info) {
  //   addPlant(info.raw.localPosition);
  //   super.onTapDown(info);
  // }
}

void main() {
  runApp(GameWidget(
    game: MyGame(),
    overlayBuilderMap: {
      'Plant': (context, MyGame game) {
        return PlantOverlay(game: game);
      },
      'Sun': (context, MyGame game) {
        return SunOverlay(game: game);
      },
      'MainMenu': (context, MyGame game) {
        return MainMenuOverlay(game: game);
      },
      'Statistics': (context, MyGame game) {
        return StatisticsOverlay(
          game: game,
        );
      },
    },
    initialActiveOverlays: const [
      'Plant',
      'Sun',
      'Statistics' /*, "MainMenu"*/
    ],
  ));
}
