import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:fun_prize/model/game_engine.dart';
import 'package:fun_prize/widgets/game/background_component.dart';
import 'package:fun_prize/widgets/game/character_component.dart';
import 'package:fun_prize/widgets/game/obstacle_component.dart';
import 'package:fun_prize/widgets/game/score_component.dart';


class PrizeFunGame extends BaseGame {
  final GameEngine engine;
  final double minWinnerScore;

  final Util _util = Util();

  BackgroundComponent _backgroundComponent = BackgroundComponent();
  List<ObstacleComponent> _obstacleComponents = List();
  CharacterComponent _characterComponent;
  ScoreComponent _scoreComponent;

  GestureRecognizer get _jumpGestureRecognizer => VerticalDragGestureRecognizer()
    ..onStart = (_) => engine.jump();

  PrizeFunGame({this.engine, this.minWinnerScore = 1000}) {
    _util.setLandscape();
    _util.fullScreen();
    _characterComponent = CharacterComponent(engine: engine);
    _scoreComponent = ScoreComponent(engine, minWinnerScore: minWinnerScore);
    components.addAll([
      _backgroundComponent, _characterComponent, _scoreComponent
    ]);
    engine.start();
    engine.position.listen((position) {
      _characterComponent.y = _translateCharacterY(position.y);
    });
    engine.obstacles
      .map((obstacle) => ObstacleComponent(obstacle))
      .listen((obstacle) => _obstacleComponents.add(obstacle));
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
    _scoreComponent.render(canvas);
    _obstacleComponents.forEach((obstacle) => obstacle.render(canvas));
  }

  @override
  void update(double time) {
    engine.update(time);
    _characterComponent.update(time);
    _backgroundComponent.update(time);
    _scoreComponent.update(time);
  }

  double _translateCharacterY(double y) => (size?.height ?? 0) - _characterComponent.height * 1.25 - y;
}