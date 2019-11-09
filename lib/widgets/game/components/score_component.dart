import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/text_component.dart';
import 'package:fun_prize/model/game_engine.dart';


class ScoreComponent extends PositionComponent {
  final GameEngine engine;
  final TextComponent _scoreTextComponent = TextComponent("");
  final TextComponent _minWinnerTextComponent = TextComponent("");

  ScoreComponent(this.engine, {double minWinnerScore}) {
    engine.score.listen((score) {
      _scoreTextComponent.text = "Ton score : ${score.toInt()}";
    });
    _minWinnerTextComponent.text = "Score à battre : ${minWinnerScore.toInt()}";
  }

  @override
  void render(Canvas canvas) {
    _minWinnerTextComponent.render(canvas);
    _scoreTextComponent.render(canvas);
  }

  @override
  void update(double t) { }

  @override
  void resize(Size size) {
    super.resize(size);
    _minWinnerTextComponent.x = size.width - _minWinnerTextComponent.width - 16;
    _minWinnerTextComponent.y = 16;
    _scoreTextComponent.x = 0;
    _scoreTextComponent.y = _minWinnerTextComponent.height + 8;
  }
}