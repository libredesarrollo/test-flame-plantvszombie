import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import 'package:flame/input.dart';

import 'package:flame/components.dart';
import 'package:plantsvszombie/main.dart';

import 'package:plantsvszombie/utils/create_animation_by_limit.dart';

class SunComponent extends SpriteAnimationComponent
    with Tappable, HasGameRef<MyGame> {
  //MyGame game;

  SunComponent(/*{required this.game}*/) : super() {
    debugMode = true;
  }

  static const int circleSpeed = 20;
  static const double circleWidth = 26, circleHeight = 26;

  final double spriteSheetWidth = 26, spriteSheetHeight = 26;
  double countSin = 0;

  Random random = Random();

  late double screenWidth, screenHeight;

  // final ShapeHitbox hitbox = CircleHitbox();

  @override
  Future<void>? onLoad() async {
    screenWidth = MediaQueryData.fromWindow(window).size.width;
    screenHeight = MediaQueryData.fromWindow(window).size.height;

    position = Vector2(random.nextDouble() * screenWidth, -circleHeight);

    size = Vector2(circleWidth, circleHeight);

    final spriteImage = await Flame.images.load('sun.png');
    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    animation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 2, sizeX: 2, stepTime: .8);

    // hitbox.renderShape = false;
    // hitbox.collisionType = CollisionType.passive;

    // add(hitbox);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameRef.resetGame) {
      removeFromParent();
    }

    // position.y += circleSpeed * dt;
    // print(position.y);
    countSin += 0.02;
    // position.x += sin(countSin) * 5;
    position += Vector2(sin(countSin) * 1, circleSpeed * dt);
    super.update(dt);
    if (position.y > screenHeight) {
      removeFromParent();
    }
  }

  @override
  bool onTapDown(TapDownInfo info) {
    removeFromParent();
    game.addSuns(5);
    return false;
  }

  // @override
  // void onCollision(Set<Vector2> points, PositionComponent other) {
  //   if (other is ScreenHitbox) {}

  //   super.onCollision(points, other);
  // }
}
