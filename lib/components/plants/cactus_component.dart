import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:plantsvszombie/utils/create_animation_by_limit.dart';

import 'package:plantsvszombie/components/plants/plant_component.dart';

class CactusComponent extends PlantComponent {
  @override
  Future<void>? onLoad() async {
    spriteSheetWidth = 39;
    spriteSheetHeight = 37;
    final spriteImage = await Flame.images.load('PlantCactus.png');

    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    // init animation
    idleAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 4, sizeX: 6, stepTime: .2);
    shootAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 4, step: 2, sizeX: 6, stepTime: .2);

    animation = idleAnimation;
    size = Vector2(spriteSheetWidth, spriteSheetHeight);

    body = RectangleHitbox(
      size: Vector2(spriteSheetWidth, spriteSheetHeight - 40),
    )..collisionType = CollisionType.active;
    add(body);
    return super.onLoad();
  }
}
