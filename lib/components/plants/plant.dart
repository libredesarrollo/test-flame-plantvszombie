import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Plant extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks {
  double spriteSheetWidth = 128, spriteSheetHeight = 128;

  late SpriteAnimation idleAnimation, shootAnimation;

  late RectangleHitbox body;
}
