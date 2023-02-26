import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class ZombieComponent extends SpriteAnimationComponent {
  late SpriteAnimation walkingAnimation;

  double speed = 12;

  double spriteSheetWidth = 128, spriteSheetHeight = 128;

  late RectangleHitbox body;

  ZombieComponent(position) : super(position: position) {
    debugMode = true;
    scale = Vector2.all(1);
  }

  @override
  void update(double dt) {
    position.add(Vector2(-dt * speed, 0));
    super.update(dt);
  }
}
