import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:plantsvszombie/main.dart';

class SeedComponent extends PositionComponent with TapCallbacks {
  MyGame game;
  bool sown = false;
  bool busy = false;
  Vector2 positionCopy = Vector2(0, 0);

  SeedComponent({required size, required position, required this.game})
      : super(size: size, position: position) {
    debugMode = true;
    // scale = Vector2.all(game.factScale);
    // scale = Vector2.all(3)

    // size = Vector2.all(size.x * 3);
    print(game.factScale.toString() + '---------');
    positionCopy = position;
    add(RectangleHitbox()..collisionType = CollisionType.active);
  }

  @override
  FutureOr<void> onLoad() {
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    position = positionCopy * game.factScale;
    scale = Vector2.all(game.factScale);
    super.onGameResize(size);
  }

  // @override
  // void update(double dt) {
  //   position *= game.factScale;

  //   super.update(dt);
  // }

  @override
  void onTapDown(TapDownEvent event) {
    if (!sown & !busy) {
      // game.addPlant(info.raw.localPosition);
      Vector2 auxPos = position;
      auxPos += size / 2;

      // game.addPlant(auxPos);
      if (game.addPlant(position, size)) {
        sown = true;
      }
    }
    super.onTapDown(event);
  }
}
