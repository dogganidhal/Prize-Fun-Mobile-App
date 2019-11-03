import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

class BackgroundComponent extends PositionComponent {
  Sprite bgSprite = Sprite('backgrounds/city01.png');
  Rect bgRect;

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void resize(Size size) {
    bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
  }

  @override
  void update(double time) {

  }
}