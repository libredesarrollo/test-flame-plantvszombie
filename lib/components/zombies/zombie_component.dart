import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:plantsvszombie/components/plants/cactus_component.dart';
import 'package:plantsvszombie/components/plants/peashooter_component.dart';
import 'package:plantsvszombie/components/plants/projectile_component.dart';
import 'package:plantsvszombie/helpers/enemies/movements.dart';
import 'package:plantsvszombie/maps/seed_component.dart';

const double alignZombie = 20;

class ZombieComponent extends SpriteAnimationComponent with CollisionCallbacks {
  late SpriteAnimation walkingAnimation;

  double speed = 12;

  double spriteSheetWidth = 128, spriteSheetHeight = 128;

  late RectangleHitbox body;

  int life = 100;
  int damage = 20;

  bool isAttacking = false;
  bool attack = false;
  double elapsedTimeAttaking = 0;

  ZombieComponent(position) : super(position: position) {
    debugMode = true;
    scale = Vector2.all(1);
  }

  @override
  void update(double dt) {
    if (!isAttacking) position.add(Vector2(-dt * speed, 0));

    if (position.x <= -size.x) {
      //print(position.x.toString());
      // el zombie llego al final

      _setChannel(false);
      removeFromParent();
    }

    if (elapsedTimeAttaking > 2) {
      elapsedTimeAttaking = 0.0;
      attack = true;
    }

    elapsedTimeAttaking += dt;

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is SeedComponent) _setChannel(true);

    if (other is ProjectileComponent) {
      other.removeFromParent();
      life -= other.damage;
      if (life <= 0) {
        removeFromParent();
      }
    }

    if (other is CactusComponent) {
      isAttacking = true;
      if (attack) {
        attack = false;
        other.life -= damage;
        if (other.life <= 0) {
          other.removeFromParent();
        }
      }
    }

    if (other is PeashooterComponent) {
      isAttacking = true;
      if (attack) {
        print('atacando' + other.life.toString());
        attack = false;
        other.life -= damage;
        if (other.life <= 0) {
          other.removeFromParent();
        }
      }
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void onRemove() {
    _setChannel(false);
    super.onRemove();
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is PeashooterComponent || other is CactusComponent) {
      isAttacking = false;
      attack = false;
    }
    super.onCollisionEnd(other);
  }

  _setChannel(bool value) {
    if (position.y + alignZombie == 48) {
      enemiesInChannel[0] = value;
    } else if (position.y + alignZombie == 96) {
      enemiesInChannel[1] = value;
    } else if (position.y + alignZombie == 144) {
      enemiesInChannel[2] = value;
    } else if (position.y + alignZombie == 192) {
      enemiesInChannel[3] = value;
    } else if (position.y + alignZombie == 240) {
      enemiesInChannel[4] = value;
    } else if (position.y + alignZombie == 288) {
      enemiesInChannel[5] = value;
    } else if (position.y + alignZombie == 336) {
      enemiesInChannel[6] = value;
    }

    // enemiesInChannel[((position.y + alignZombie) / sizeTileMap).toInt()] = true;
    //print(enemiesInChannel.toString());
  }
}
