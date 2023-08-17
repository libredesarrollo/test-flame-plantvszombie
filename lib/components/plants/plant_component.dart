import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flame/sprite.dart';

import 'package:plantsvszombie/components/plants/projectile_component.dart';
import 'package:plantsvszombie/helpers/enemies/movements.dart';
import 'package:plantsvszombie/main.dart';

import 'package:plantsvszombie/utils/create_animation_by_limit.dart';

import 'dart:math';

enum State { idle, shoot }

enum Plants { peashooter, cactus }

class PlantCost {
  static const peaschooter = 20;
  static const cactus = 30;

  static int cost(Plants plant) {
    switch (plant) {
      case Plants.peashooter:
        return peaschooter;
      case Plants.cactus:
        return cactus;
    }
  }
}

class PlantComponent extends SpriteAnimationComponent
    with
        KeyboardHandler,
        CollisionCallbacks,
        HasGameRef<MyGame>,
        DragCallbacks {
  double spriteSheetWidth = 128, spriteSheetHeight = 128;

  late SpriteAnimation idleAnimation, shootAnimation;

  late RectangleHitbox body;

  double elapsedTime = 0;

  State state = State.idle;

  late Sprite projectile;
  Vector2 sizeMap;

  int life = 100;
  int damage = 10;

  Vector2 positionOriginal = Vector2(0, 0);

  PlantComponent(this.sizeMap, position) : super(position: position) {
    debugMode = true;
    // position = Vector2.all(200);
    positionOriginal = position;
  }

  @override
  void update(double dt) async {
    if (gameRef.resetGame) {
      removeFromParent();
    }

    if (enemiesInChannel[(positionOriginal.y / sizeTileMap).toInt() - 1]) {
      // hay enemigos en en canal
      if (state != State.shoot) {
        animation = shootAnimation;
        // add(ProjectileComponent(
        //     projectile: await Sprite.load('PlantPeashooterProjectile.png')));
      }
      state = State.shoot;
    } else {
      if (state != State.idle) {
        animation = idleAnimation;
      }
      state = State.idle;
    }

    // elapsedTime += dt;

    // if (elapsedTime > 3.0) {
    //   changeDirection();
    //   elapsedTime = 0.0;
    // }

    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    scale = Vector2.all(game.factScale);
    position = positionOriginal * game.factScale;
    super.onGameResize(size);
  }

  // @override
  // void onDragStart(DragStartEvent event) {
  //   print('canvasPosition--' + event.canvasPosition.toString());
  //   print('devicePosition--' + event.devicePosition.toString());
  //   print('localPosition--' + event.localPosition.toString());
  //   print('parentPosition--' + event.parentPosition.toString());
  //   super.onDragStart(event);
  // }

  // @override
  // void onDragUpdate(DragUpdateEvent event) {
  //   print('canvasPosition--' + event.canvasPosition.toString());
  //   print('devicePosition--' + event.devicePosition.toString());
  //   print('localPosition--' + event.localPosition.toString());
  //   print('parentPosition----' + event.parentPosition.toString());
  //   print('event--' + event.delta.toString());

  //   final camera = gameRef.firstChild<CameraComponent>()!;
  //   // camera.moveBy(event.delta / camera.viewfinder.zoom);
  //   camera.moveBy(event.delta);
  //   // camera.viewfinder.position += (event.delta / camera.viewfinder.zoom);
  //   // camera.viewport.position += (event.delta / camera.viewfinder.zoom);
  //   // camera.viewport.position += (event.delta / camera.viewfinder.zoom);
  //   // camera.viewport.position

  //   print('viewfinder--' + camera.viewfinder.position.toString());
  //   super.onDragUpdate(event);
  // }

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

  void shoot(String sprite, Vector2 position) {
    // shootAnimation.onComplete = () async {
    //   add(ProjectileComponent(
    //       projectile: await Sprite.load(sprite),
    //       sizeMap: sizeMap,
    //       position: position,
    //       damage: damage));
    //   shootAnimation.reset();
    // };
  }
}
