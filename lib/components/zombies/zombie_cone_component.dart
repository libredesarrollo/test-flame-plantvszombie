import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:plantsvszombie/utils/create_animation_by_limit.dart';
import 'package:plantsvszombie/components/zombies/zombie_component.dart';

class ZombieConeComponent extends ZombieComponent {
  ZombieConeComponent({required position}) : super(position) {
    // spriteSheetWidth = 29.2;
    spriteSheetWidth = 27.6;
    spriteSheetHeight = 55.5;
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    speed = 15;
  }

  @override
  Future<void>? onLoad() async {
    final spriteImage = await Flame.images.load('zombieCone.png');

    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    walkingAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 5, step: 6, sizeX: 19, stepTime: .2);

    animation = walkingAnimation;

    size = Vector2(spriteSheetWidth, spriteSheetHeight);

    body = RectangleHitbox()..collisionType = CollisionType.passive;
    add(body);
    return super.onLoad();
  }
}
