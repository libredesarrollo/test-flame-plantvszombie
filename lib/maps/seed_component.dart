import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:plantsvszombie/main.dart';

class SeedComponent extends PositionComponent with Tappable {
  MyGame game;
  bool sown = false;

  SeedComponent({required size, required position, required this.game})
      : super(size: size, position: position) {
    debugMode = false;
    add(RectangleHitbox()..collisionType = CollisionType.active);
  }

  @override
  FutureOr<void> onLoad() {
    return super.onLoad();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (!sown) {
      // game.addPlant(info.raw.localPosition);
      Vector2 auxPos = position;
      auxPos += size / 2;

      // game.addPlant(auxPos);
      if (game.addPlant(position, size)) {
        sown = true;
      }
    }
    return true;
  }
}
