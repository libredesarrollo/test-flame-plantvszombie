import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:plantsvszombie/main.dart';

class SeedComponent extends PositionComponent with Tappable {
  MyGame game;

  SeedComponent({required size, required position, required this.game})
      : super(size: size, position: position) {
    debugMode = true;
    add(RectangleHitbox()..collisionType = CollisionType.active);
  }

  @override
  FutureOr<void> onLoad() {
    return super.onLoad();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    game.addPlant(info.raw.localPosition);
    return true;
  }
}
