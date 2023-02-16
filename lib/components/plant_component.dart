import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:plantsvszombie/components/character.dart';

import 'package:plantsvszombie/utils/create_animation_by_limit.dart';

import 'dart:math';

class PlantComponent extends Character {
  double elapsedTime = 0;

  PlantComponent() : super() {
    debugMode = true;
    scale = Vector2.all(2);
  }

  @override
  Future<void>? onLoad() async {
    spriteSheetWidth = 27;
    spriteSheetHeight = 31;
    final spriteImage = await Flame.images.load('PlantPeashooter.png');

    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    // init animation
    idleAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 8, sizeX: 8, stepTime: .2);
    // downAnimation = spriteSheet.createAnimationByLimit(
    //     xInit: 0, yInit: 0, step: 8, sizeX: 8, stepTime: .2);
    // leftAnimation = spriteSheet.createAnimationByLimit(
    //     xInit: 1, yInit: 0, step: 8, sizeX: 8, stepTime: .2);
    // rightAnimation = spriteSheet.createAnimationByLimit(
    //     xInit: 2, yInit: 0, step: 8, sizeX: 8, stepTime: .2);
    // upAnimation = spriteSheet.createAnimationByLimit(
    //     xInit: 3, yInit: 0, step: 8, sizeX: 8, stepTime: .2);
    // end animation

    reset();

    body = RectangleHitbox(
      size: Vector2(spriteSheetWidth, spriteSheetHeight - 40),
    )..collisionType = CollisionType.active;
    add(body);
    return super.onLoad();
  }

  void reset({bool dead = false}) {
    animation = idleAnimation;
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    position = Vector2(300, 300);
    movementType = MovementType.idle;
  }

  @override
  void update(double dt) {
    // elapsedTime += dt;

    // if (elapsedTime > 3.0) {
    //   changeDirection();
    //   elapsedTime = 0.0;
    // }

    super.update(dt);
  }

  // @override
  // void onCollision(Set<Vector2> points, PositionComponent other) {
  //   if (other is WaterComponent || other is ObjectComponent) {
  //     if (playerCollisionDirection == null) {
  //       // ??=
  //       playerCollisionDirection = playerDirection;
  //     }
  //   }

  //   super.onCollision(points, other);
  // }

  // @override
  // void onCollisionEnd(PositionComponent other) {
  //   if (other is WaterComponent || other is ObjectComponent) {
  //     playerCollisionDirection = null;
  //   }

  //   super.onCollisionEnd(other);
  // }
}
