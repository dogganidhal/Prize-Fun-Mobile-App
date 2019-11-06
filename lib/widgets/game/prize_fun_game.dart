import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:fun_prize/model/game_engine.dart';
import 'package:fun_prize/widgets/game/background_component.dart';
import 'package:fun_prize/widgets/game/bonus_component.dart';
import 'package:fun_prize/widgets/game/character_component.dart';
import 'package:fun_prize/widgets/game/cop_component.dart';
import 'package:fun_prize/widgets/game/obstacle_component.dart';
import 'package:fun_prize/widgets/game/score_component.dart';


class PrizeFunGame extends BaseGame {
  final GameEngine engine;
  final double minWinnerScore;

  final Util _util = Util();

  List<ObstacleComponent> _obstacleComponents = [];
  List<BonusComponent> _bonusComponents = [];

  BackgroundComponent _backgroundComponent;
  CharacterComponent _characterComponent;
  ScoreComponent _scoreComponent;
  CopComponent _copComponent;

  GestureRecognizer get _jumpGestureRecognizer => VerticalDragGestureRecognizer()
    ..onStart = (_) => engine.jump();

  PrizeFunGame({this.engine, this.minWinnerScore = 1000}) {
    _util.setLandscape();
    _util.fullScreen();
    _characterComponent = CharacterComponent(engine);
    _scoreComponent = ScoreComponent(engine, minWinnerScore: minWinnerScore);
    _backgroundComponent = BackgroundComponent(engine);
    _copComponent = CopComponent(engine);
    [_backgroundComponent, _characterComponent, _copComponent, _scoreComponent]
      .forEach((component) => add(component));
    engine.start();
    engine.position.listen((position) {
      _characterComponent.y = _translateCharacterY(position.y);
    });
    engine.obstacles
      .map((obstacle) => ObstacleComponent(obstacle, engine: engine))
      .listen((obstacle) {
        _obstacleComponents.add(obstacle);
        add(obstacle);
      });
    engine.bonus
      .map((bonus) => BonusComponent(bonus, engine: engine))
      .listen((bonus) {
        _bonusComponents.add(bonus);
        add(bonus);
      });
  }

  void onAttach() {
    _util.addGestureRecognizer(_jumpGestureRecognizer);
  }

  void dispose() {
    engine.dispose();
  }

  void update(double time) {
    super.update(time);
    engine.update(time);
  }

  double _translateCharacterY(double y) => (size?.height ?? 0) - _characterComponent.height * 1.25 - y;
}