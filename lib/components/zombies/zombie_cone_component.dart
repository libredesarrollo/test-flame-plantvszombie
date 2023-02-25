import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:plantsvszombie/components/zombies/zombie_component.dart';
import 'package:plantsvszombie/utils/create_animation_by_limit.dart';

import 'package:plantsvszombie/components/plants/plant_component.dart';

class ZombieConeComponent extends ZombieComponent {
  ZombieConeComponent({required position}) : super(position) {
    // spriteSheetWidth = 29.2;
    spriteSheetWidth = 27.6;
    spriteSheetHeight = 55.5;
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
  }

  @override
  Future<void>? onLoad() async {
    final spriteImage = await Flame.images.load('zombieCone.png');

    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    // init animation
    walkingAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 5, step: 6, sizeX: 19, stepTime: .2);
    // walkingAnimation = spriteSheet.createAnimationByLimit(
    //     xInit: 0, yInit: 0, step: 4, sizeX: 4, stepTime: .2);

    animation = walkingAnimation;

    size = Vector2(spriteSheetWidth, spriteSheetHeight);

    body = RectangleHitbox(
      size: Vector2(spriteSheetWidth, spriteSheetHeight),
    )..collisionType = CollisionType.active;
    add(body);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // if (elapsedTime > 1.0) {
    // position.x += -50 * dt;
    position.add(Vector2(-dt * speed, 0));
    //   elapsedTime = 0.0;
    // }
    // elapsedTime += dt;
    super.update(dt);
  }
}
