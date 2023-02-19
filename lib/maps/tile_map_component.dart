import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flame_tiled/flame_tiled.dart';
import 'package:plantsvszombie/main.dart';
import 'package:plantsvszombie/maps/seed_component.dart';

import 'package:tiled/tiled.dart';

class TileMapComponent extends PositionComponent {
  late TiledComponent tiledMap;
  late Vector2 posPlayer;
  MyGame game;

  TileMapComponent({required this.game});

  @override
  Future<void>? onLoad() async {
    tiledMap = await TiledComponent.load('map.tmx', Vector2.all(48));
    add(tiledMap);

    // final objWater = tiledMap.tileMap.getLayer<ObjectGroup>("water_object");

    // for (final obj in objWater!.objects) {
    //   add(SeedComponent(
    //       size: Vector2(obj.width, obj.height),
    //       position: Vector2(obj.x, obj.y)));
    // }

    final objObs = tiledMap.tileMap.getLayer<ObjectGroup>("obstacles_object");

    for (final obj in objObs!.objects) {
      add(SeedComponent(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y),
          game: game));
    }

    // final objPlayer = tiledMap.tileMap.getLayer<ObjectGroup>("player_object");
    // posPlayer = Vector2(objPlayer!.objects[0].x, objPlayer.objects[0].y);

    return super.onLoad();
  }
}
