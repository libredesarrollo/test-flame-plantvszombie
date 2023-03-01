import 'package:flame/components.dart';

class ProjectileComponent extends SpriteComponent {
  final Sprite projectile;
  ProjectileComponent({required this.projectile})
      : super(size: Vector2.all(20), sprite: projectile);
}
