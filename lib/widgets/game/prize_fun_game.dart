import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:fun_prize/model/game_engine.dart';
import 'package:fun_prize/widgets/game/background_component.dart';
import 'package:fun_prize/widgets/game/bonus_component.dart';
import 'package:fun_prize/widgets/game/character_component.dart';
import 'package:fun_prize/widgets/game/obstacle_component.dart';


class PrizeFunGame extends BaseGame {
  final GameEngine engine;
  final Util _util = Util();
  BackgroundComponent _backgroundComponent = BackgroundComponent();
  List<ObstacleComponent> _obstacleComponents;
  List<BonusComponent> _bonusComponents;
  CharacterComponent _characterComponent;

  GestureRecognizer get _jumpGestureRecognizer => VerticalDragGestureRecognizer()
    ..onStart = (_) => engine.jump();

  PrizeFunGame({this.engine}) {
    _util.setLandscape();
    _util.fullScreen();
    _characterComponent = CharacterComponent(engine: engine);
    components.addAll([_backgroundComponent, _characterComponent]);
    engine.start();
    engine.position.listen((position) => {
      _characterComponent.y = _translateCharacterY(position.y)
    });
  }

  void onAttach() {
    _util.addGestureRecognizer(_jumpGestureRecognizer);
  }

  void dispose() {
    engine.dispose();
  }

  @override
  void render(Canvas canvas) {
    _backgroundComponent.render(canvas);
    _characterComponent.render(canvas);
  }

  @override
  void update(double time) {
    engine.update(time);
    _characterComponent.update(time);
    _backgroundComponent.update(time);
  }

  @override
  void resize(Size size) {
    _characterComponent.y = _translateCharacterY(0);
    super.resize(size);
  }

  double _translateCharacterY(double y) => (size?.height ?? 0) - _characterComponent.height * 1.25 - y;
}