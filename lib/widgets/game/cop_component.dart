import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/sprite.dart';

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

  CopComponent() : super(0, 0, _kCopAnimation);

  void resize(Size size) {
    super.resize(size);
    width = size.height / 5;
    height = width * 1.67;
    x = 16;
    y = size.height - height - 32;
  }
}