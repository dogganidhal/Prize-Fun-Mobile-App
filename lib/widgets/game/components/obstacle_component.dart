import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:fun_prize/model/game_engine.dart';
import 'package:fun_prize/model/obstacle_spec.dart';

class ObstacleComponent extends PositionComponent {
  final ObstacleSpec spec;
  final GameEngine engine;

  Sprite _sprite;
  Size _screenSize = Size.zero;

  ObstacleComponent(this.spec, {this.engine}) {
    x = spec.distance;
    switch(spec.type) {
      case ObstacleType.BOX:
        _sprite = Sprite("obstacles/box.png", width: spec.width, height: spec.height);
        break;
    }
    engine.position
      .map((position) => position.distance)
      .listen((distance) {
        x = spec.distance - distance;
      });
  }

  void resize(Size size) {
    _screenSize = size;
    y = size.height - 48 - 16;
  }

  void render(Canvas canvas) {
    if (x > 0 && x < _screenSize.width) {
      _sprite.renderRect(canvas, Rect.fromLTWH(x, y, spec.width, spec.height));
    }
  }

  void update(double time) { }
}