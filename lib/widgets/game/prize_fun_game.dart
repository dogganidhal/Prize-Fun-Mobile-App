import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/util.dart';
import 'package:fun_prize/model/game_engine.dart';
import 'package:fun_prize/widgets/game/background_component.dart';
import 'package:fun_prize/widgets/game/bonus_component.dart';
import 'package:fun_prize/widgets/game/characrter_component.dart';
import 'package:fun_prize/widgets/game/obstacle_component.dart';


class PrizeFunGame extends BaseGame {
  final GameEngine engine;
  BackgroundComponent _backgroundComponent = BackgroundComponent();
  List<ObstacleComponent> _obstacleComponents;
  List<BonusComponent> _bonusComponents;
  CharacterComponent _characterComponent;

  PrizeFunGame({this.engine}) {
    Util().setLandscape();
    Util().fullScreen();
    _characterComponent = CharacterComponent(engine: engine);
    components.addAll([_backgroundComponent, _characterComponent]);
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
    _characterComponent.update(time);
    _backgroundComponent.update(time);
  }
}