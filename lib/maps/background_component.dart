import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';

class BackgroundComponent extends PositionComponent
    with HasGameRef, DragCallbacks {
  late RectangleComponent _rectangleComponent;
  @override
  FutureOr<void> onLoad() {
    print('*******' + gameRef.size.toString());
    size = gameRef.size;
    scale = Vector2.all(1);
    _rectangleComponent = RectangleComponent(
        position: Vector2.all(0),
        size: gameRef.size,
        paint: Paint()..color = const Color(0xFFFF0000));

    add(_rectangleComponent);

    return super.onLoad();
  }

  // @override
  // void render(Canvas canvas) {
  //   canvas.drawRect(Rect.fromLTRB(0, 0, gameRef.size.x, gameRef.size.y),
  //       Paint()..color = const Color(0xFFFFDD00));
  // }

  @override
  void onGameResize(Vector2 size) {
    print('*******' + size.toString());
    // _rectangleComponent.size = size;
    super.onGameResize(size);
  }

  @override
  void onDragStart(DragStartEvent event) {
    print('canvasPosition--' + event.canvasPosition.toString());
    print('devicePosition--' + event.devicePosition.toString());
    print('localPosition--' + event.localPosition.toString());
    print('parentPosition--' + event.parentPosition.toString());
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    print('canvasPosition--' + event.canvasPosition.toString());
    print('devicePosition--' + event.devicePosition.toString());
    print('localPosition--' + event.localPosition.toString());
    print('parentPosition--' + event.parentPosition.toString());
    print('event--' + event.delta.toString());

    final camera = gameRef.firstChild<CameraComponent>()!;
    camera.moveBy(event.delta / camera.viewfinder.zoom);
    _rectangleComponent.position = camera.viewfinder.position;
    super.onDragUpdate(event);
  }
}
