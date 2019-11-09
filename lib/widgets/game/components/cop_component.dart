import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:fun_prize/model/game_engine.dart';

class CopComponent extends AnimationComponent {
  static final double _kSecondsPerFrame = 1 / 10;
  static final Animation _kCopAnimation = Animation([
    "cop/0.png",
    "cop/1.png",
    "cop/2.png",
    "cop/3.png",
    "cop/4.png",
    "cop/5.png"
  ]
    .map((image) => Sprite(image))
    .map((sprite) => Frame(sprite, _kSecondsPerFrame))
    .toList());

  final GameEngine engine;

  CopComponent(this.engine) : super(0, 0, _kCopAnimation) {
    width = GameEngine.kCopWidth;
    height = GameEngine.kCopHeight;
    x = double.negativeInfinity;
    engine.status.listen((status) {
      switch(status) {
        case GameStatus.CLEAN:
          break;
        case GameStatus.HIT_ONCE:
          x = 16;
          break;
        case GameStatus.LOST:
          animation.loop = false;
          x = width;
          break;
      }
    });
  }

  void resize(Size size) {
    super.resize(size);
    y = size.height - height - 16;
  }
}