import 'package:flame/game.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:fun_prize/model/game_engine.dart';
import 'package:fun_prize/widgets/game/components/background_component.dart';
import 'package:fun_prize/widgets/game/components/bonus_component.dart';
import 'package:fun_prize/widgets/game/components/character_component.dart';
import 'package:fun_prize/widgets/game/components/cop_component.dart';
import 'package:fun_prize/widgets/game/components/obstacle_component.dart';
import 'package:fun_prize/widgets/game/components/recap_component.dart';
import 'package:fun_prize/widgets/game/components/score_component.dart';


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
  RecapComponent _recapComponent;

  GestureRecognizer get _jumpGestureRecognizer => VerticalDragGestureRecognizer()
    ..onStart = (_) => engine.jump();

  PrizeFunGame({this.engine, this.minWinnerScore = 1000}) {
    _util.setLandscape();
    _util.fullScreen();
    _characterComponent = CharacterComponent(engine);
    _scoreComponent = ScoreComponent(engine, minWinnerScore: minWinnerScore);
    _backgroundComponent = BackgroundComponent(engine);
    _copComponent = CopComponent(engine);
    _recapComponent = RecapComponent(engine: engine);
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
    engine.status
      .listen((status) {
        if (status == GameStatus.LOST) {
          add(_recapComponent);
        }
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