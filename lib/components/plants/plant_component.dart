import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flame/sprite.dart';
import 'package:plantsvszombie/components/plants/plant.dart';
import 'package:plantsvszombie/components/plants/projectile_component.dart';
import 'package:plantsvszombie/helpers/enemies/movements.dart';

import 'package:plantsvszombie/utils/create_animation_by_limit.dart';

import 'dart:math';

enum State { idle, shoot }

class PlantComponent extends Plant {
  double elapsedTime = 0;

  State state = State.idle;

  late Sprite projectile;

  PlantComponent() : super() {
    debugMode = true;
    scale = Vector2.all(1);
    position = Vector2.all(200);
  }

  @override
  void update(double dt) async {
    if (enemiesInChannel[(position.y / sizeTileMap).toInt() - 1]) {
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

  void shoot() {
    shootAnimation.onComplete = () async {
      add(ProjectileComponent(
          projectile: await Sprite.load('PlantPeashooterProjectile.png')));
      shootAnimation.reset();
    };
  }
}
