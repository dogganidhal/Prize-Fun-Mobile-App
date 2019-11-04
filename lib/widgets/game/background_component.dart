import 'dart:ui';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

class BackgroundComponent extends PositionComponent {
  Rect bgRect;
  List<Sprite> _staticSprites = List<Sprite>()
    ..add(Sprite("backgrounds/background.png"))
    ..add(Sprite("backgrounds/background-buildings.png"))
    ..add(Sprite("backgrounds/background-buildings2.png"))
    ..add(Sprite("backgrounds/clouds.png"))
    ..add(Sprite("backgrounds/clouds2.png"));
  List<Sprite> _dynamicSprites = List<Sprite>()
    ..add(Sprite("backgrounds/foreground-buildings.png"))
    ..add(Sprite("backgrounds/ground.png"))
    ..add(Sprite("backgrounds/lamps.png"));

  void render(Canvas c) {
    _staticSprites.forEach((sprite) => sprite.renderRect(c, bgRect));
    _dynamicSprites.forEach((sprite) => sprite.renderRect(c, bgRect));
  }

  void resize(Size size) {
    bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
  }

  @override
  void update(double time) {

  }
}