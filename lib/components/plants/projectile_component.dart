import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class ProjectileComponent extends SpriteComponent {
  final Sprite projectile;
  final double speed;

  ProjectileComponent({required this.projectile, this.speed = 80})
      : super(size: Vector2.all(20), sprite: projectile) {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.add(Vector2(dt * speed, 0));

    if (position.x >= 1200) {
      removeFromParent();
    }

    super.update(dt);
  }
}
