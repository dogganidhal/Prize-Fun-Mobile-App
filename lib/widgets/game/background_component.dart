import 'dart:ui';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/sprite.dart';
import 'package:fun_prize/model/game_engine.dart';

class BackgroundComponent extends ParallaxComponent {
  static final List<ParallaxImage> _kBackgroundParallaxImages = [
    ParallaxImage("backgrounds/background.png"),
    ParallaxImage("backgrounds/background-buildings.png"),
    ParallaxImage("backgrounds/background-buildings2.png"),
    ParallaxImage("backgrounds/clouds.png"),
    ParallaxImage("backgrounds/clouds2.png"),
    ParallaxImage("backgrounds/foreground-buildings.png"),
    ParallaxImage("backgrounds/lamps.png"),
    ParallaxImage("backgrounds/ground.png")
  ];

  final GameEngine engine;

  double _distance = 0.0;

  BackgroundComponent(this.engine)
    : super(_kBackgroundParallaxImages, baseSpeed: Offset(0, 0), layerDelta: Offset(20, 0)) {
    engine.position
      .map((position) => position.distance)
      .listen((distance) {
        final dx = distance - _distance;
        _distance = distance;
        baseSpeed = Offset(dx, baseSpeed.dy);
      });
    engine.status
      .listen((status) {
        if (status == GameStatus.LOST) {
          layerDelta = Offset.zero;
          baseSpeed = Offset.zero;
        }
      });
  }
}