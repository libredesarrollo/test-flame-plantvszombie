import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:plantsvszombie/utils/create_animation_by_limit.dart';
import 'package:plantsvszombie/components/zombies/zombie_component.dart';

class ZombieDoorComponent extends ZombieComponent {
  ZombieDoorComponent({required position}) : super(position) {
    // spriteSheetWidth = 29.2;
    spriteSheetWidth = 31.4;
    spriteSheetHeight = 52;
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
  }

  @override
  Future<void>? onLoad() async {
    final spriteImage = await Flame.images.load('zombieDoor.png');

    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    walkingAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 6, sizeX: 19, stepTime: .2);
    // walkingAnimation = spriteSheet.createAnimationByLimit(
    //     xInit: 0, yInit: 5, step: 6, sizeX: 19, stepTime: .2);

    animation = walkingAnimation;

    size = Vector2(spriteSheetWidth, spriteSheetHeight);

    body = RectangleHitbox()..collisionType = CollisionType.active;
    add(body);
    return super.onLoad();
  }
}
