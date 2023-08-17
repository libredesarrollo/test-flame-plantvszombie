import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:plantsvszombie/components/plants/cactus_component.dart';
import 'package:plantsvszombie/components/plants/peashooter_component.dart';
import 'package:plantsvszombie/components/plants/projectile_component.dart';
import 'package:plantsvszombie/helpers/enemies/movements.dart';
import 'package:plantsvszombie/main.dart';
import 'package:plantsvszombie/maps/seed_component.dart';

const double alignZombie = 10;

class ZombieComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  late SpriteAnimation walkingAnimation, walkingHurtAnimation, eatingAnimation;

  double speed = 50;

  double spriteSheetWidth = 128, spriteSheetHeight = 128;

  late RectangleHitbox body;

  int life = 100;
  int damage = 20;

  bool isAttacking = false;
  bool attack = false;
  double elapsedTimeAttaking = 0;

  Vector2 positionCopy = Vector2(0, 0);

  // late AudioPlayer audioWalk;
  // String audioWalkSound = 'zombie1.wav';

  ZombieComponent(position) : super(position: position) {
    debugMode = true;
    // scale = Vector2.all(1);
    positionCopy = position;
  }

  // @override
  // FutureOr<void> onLoad() {
  //   FlameAudio.loop(
  //     audioWalkSound,
  //     volume: .5,
  //   ).then((audioPlayer) {
  //     audioWalk = audioPlayer;
  //   });

  //   return super.onLoad();
  // }

  @override
  FutureOr<void> onLoad() {
    countEnemiesInMap++;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (gameRef.resetGame) {
      //audioWalk.dispose();
      removeFromParent();
    }

    if (!isAttacking) {
      position.add(Vector2(-dt * speed, 0));
      positionCopy.add(Vector2(-dt * speed, 0));
    }

    if (position.x <= -size.x) {
      //print(position.x.toString());
      // el zombie llego al final

      _setChannel(false);
      //audioWalk.dispose();
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
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CactusComponent || other is PeashooterComponent) {
      animation = eatingAnimation;
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is SeedComponent) {
      other.busy = true;
      _setChannel(true);
    }

    if (other is ProjectileComponent) {
      other.removeFromParent();
      life -= other.damage;
      if (life <= 50) {
        animation = walkingHurtAnimation;
      }
      if (life <= 0) {
        //audioWalk.dispose();
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
    countEnemiesInMap--;
    print("onRemoveonRemoveonRemove");
    _setChannel(false);
    // audioWalk.dispose();
    super.onRemove();
  }

  @override
  void onGameResize(Vector2 size) {
    scale = Vector2.all(game.factScale);
    // position.y = positionCopy.y * game.factScale;
    // position.x = positionCopy.x * game.factScale;
    position = positionCopy * game.factScale;
    super.onGameResize(size);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is SeedComponent) {
      other.busy = false;
    }

    if (other is PeashooterComponent || other is CactusComponent) {
      isAttacking = false;
      attack = false;
      if (life <= 50) {
        animation = walkingHurtAnimation;
      } else {
        animation = walkingAnimation;
      }
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
