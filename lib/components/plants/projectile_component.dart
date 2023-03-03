import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class ProjectileComponent extends SpriteComponent {
  final Sprite projectile;
  final double speed;
  final Vector2 sizeMap;

  ProjectileComponent(
      {required this.projectile, required this.sizeMap, this.speed = 120})
      : super(size: Vector2.all(20), sprite: projectile) {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.add(Vector2(dt * speed, 0));
    print(sizeMap.x.toString() + " " + position.x.toString());
    if (position.x >= sizeMap.x) {
      removeFromParent();
    }

    super.update(dt);
  }
}
