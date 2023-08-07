import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flame_tiled/flame_tiled.dart';
import 'package:plantsvszombie/main.dart';
import 'package:plantsvszombie/maps/seed_component.dart';

import 'package:tiled/tiled.dart';

class TileMapComponent extends PositionComponent
    with DragCallbacks, HasGameRef {
  late TiledComponent tiledMap;
  late Vector2 posPlayer;
  MyGame game2;

  TileMapComponent({required this.game2});

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

    final objObs = tiledMap.tileMap.getLayer<ObjectGroup>("seed");

    for (final obj in objObs!.objects) {
      add(SeedComponent(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y),
          game: game2));
    }

    // final objPlayer = tiledMap.tileMap.getLayer<ObjectGroup>("player_object");
    // posPlayer = Vector2(objPlayer!.objects[0].x, objPlayer.objects[0].y);

    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    print('canvasPosition--' + event.canvasPosition.toString());
    print('devicePosition--' + event.devicePosition.toString());
    print('localPosition--' + event.localPosition.toString());
    print('parentPosition--' + event.parentPosition.toString());
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    print('canvasPosition--' + event.canvasPosition.toString());
    print('devicePosition--' + event.devicePosition.toString());
    print('localPosition--' + event.localPosition.toString());
    print('parentPosition--' + event.parentPosition.toString());
    print('event--' + event.delta.toString());

    final camera = gameRef.firstChild<CameraComponent>()!;
    camera.moveBy(event.delta / camera.viewfinder.zoom);
    super.onDragUpdate(event);
  }
}
