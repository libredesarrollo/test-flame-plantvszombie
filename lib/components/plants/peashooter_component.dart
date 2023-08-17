import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:plantsvszombie/utils/create_animation_by_limit.dart';

import 'package:plantsvszombie/components/plants/plant_component.dart';

class PeashooterComponent extends PlantComponent {
  PeashooterComponent({required sizeMap, required position})
      : super(sizeMap, position) {
    spriteSheetWidth = 27;
    spriteSheetHeight = 31;
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
  }

  @override
  Future<void>? onLoad() async {
    final spriteImage = await Flame.images.load('PlantPeashooter.png');

    final spriteSheetIdle = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));
    final spriteSheetShoot = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth - 2, spriteSheetHeight));

    // SpriteSheet(image: spriteImage, srcSize: Vector2(15, 15));

    // init animation
    idleAnimation = spriteSheetIdle.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 8, sizeX: 8, stepTime: .2);
    shootAnimation = spriteSheetShoot.createAnimationByLimit(
        xInit: 1, yInit: 0, step: 3, sizeX: 8, stepTime: .4, loop: false);

    shoot('PlantPeashooterProjectile.png', Vector2(27, 2));

    animation = idleAnimation;

    // position = Vector2.all(300);

    body = RectangleHitbox(
      size: Vector2(spriteSheetWidth, spriteSheetHeight - 40),
    )..collisionType = CollisionType.active;
    add(body);
    return super.onLoad();
  }
}
