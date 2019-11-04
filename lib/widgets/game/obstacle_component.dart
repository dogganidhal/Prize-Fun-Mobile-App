import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:fun_prize/model/obstacle_spec.dart';

class ObstacleComponent extends PositionComponent {
  final ObstacleSpec spec;

  Sprite _sprite;

  ObstacleComponent(this.spec) {
    switch(spec.type) {
      case ObstacleType.BOX:
        _sprite = Sprite("obstacles/box.png", width: spec.width, height: spec.height);
        break;
    }
  }

  void resize(Size size) { }

  void render(Canvas canvas) {
    _sprite.renderRect(canvas, Rect.fromLTWH(spec.distance, y, spec.width, spec.height));
  }

  void update(double time) { }

}