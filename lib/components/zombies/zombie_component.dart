import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flame/sprite.dart';
import 'package:plantsvszombie/components/plants/plant.dart';

import 'package:plantsvszombie/utils/create_animation_by_limit.dart';

import 'dart:math';

class ZombieComponent extends SpriteAnimationComponent {
  late SpriteAnimation walkingAnimation;

  // double elapsedTime = 0;

  double speed = 12;

  double spriteSheetWidth = 128, spriteSheetHeight = 128;

  late RectangleHitbox body;

  ZombieComponent(position) : super(position: position) {
    debugMode = true;
    scale = Vector2.all(1);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
