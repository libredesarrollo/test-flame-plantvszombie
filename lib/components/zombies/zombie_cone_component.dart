import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:plantsvszombie/utils/create_animation_by_limit.dart';
import 'package:plantsvszombie/components/zombies/zombie_component.dart';

class ZombieConeComponent extends ZombieComponent {
  ZombieConeComponent({required position}) : super(position) {
    // spriteSheetWidth = 29.2;
    spriteSheetWidth = 37.4;
    //spriteSheetWidth = 28.6;
    spriteSheetHeight = 56;
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    speed = 15;
    // audioWalkSound = 'zombie2.wav';
  }

  @override
  Future<void>? onLoad() async {
    final spriteImage = await Flame.images.load('ZombieConeFinal.png');

    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    walkingAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 6, sizeX: 12, stepTime: .2);
    eatingAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 7, step: 6, sizeX: 12, stepTime: .2);
    walkingHurtAnimation = spriteSheet.createAnimationByLimit(
        xInit: 1, yInit: 3, step: 5, sizeX: 12, stepTime: .2);

    animation = walkingAnimation;

    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    body = RectangleHitbox(
        position: Vector2(0, 0),
        size: Vector2(spriteSheetWidth, spriteSheetHeight - alignZombie))
      ..collisionType = CollisionType.active;
    add(body);
    return super.onLoad();
  }
}
