import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:fun_prize/model/bonus_spec.dart';
import 'package:fun_prize/model/game_engine.dart';

class BonusComponent extends PositionComponent {
  final BonusSpec spec;
  final GameEngine engine;

  Sprite _sprite;
  Size _screenSize = Size.zero;

  BonusComponent(this.spec, {this.engine}) {
    x = spec.distance;
    switch(spec.type) {
      case BonusType.STAR:
        _sprite = Sprite("bonus/star.png", width: spec.width, height: spec.height);
        break;
      default:
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
    y = size.height - 48 - 16 - spec.y;
  }

  void render(Canvas canvas) {
    if (x > 0 && x < _screenSize.width && spec.visible) {
      _sprite.renderRect(canvas, Rect.fromLTWH(x, y, spec.width, spec.height));
    }
  }

  @override
  void update(double time) { }
}