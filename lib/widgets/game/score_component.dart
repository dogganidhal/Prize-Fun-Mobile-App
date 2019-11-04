import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/text_component.dart';
import 'package:fun_prize/model/game_engine.dart';


class ScoreComponent extends PositionComponent {
  final GameEngine engine;
  final TextComponent _scoreTextComponent = TextComponent("");
  final TextComponent _minWinnerTextComponent = TextComponent("");
  int _score = 0;
  String get _scoreText => "Ton score : $_score";

  ScoreComponent(this.engine, {double minWinnerScore}) {
    engine.score.listen((score) => _score = score.toInt());
    _minWinnerTextComponent.text = "À battre : ${minWinnerScore.toInt()}";
  }

  @override
  void render(Canvas c) {
    _minWinnerTextComponent.render(c);
    _scoreTextComponent.render(c);
  }

  @override
  void update(double t) {
    _scoreTextComponent.text = _scoreText;
  }

  @override
  void resize(Size size) {
    super.resize(size);
    _minWinnerTextComponent.x = 16; _minWinnerTextComponent.y = 16;
    _scoreTextComponent.x = 0;
    _scoreTextComponent.y = _minWinnerTextComponent.height + 8;

  }
}