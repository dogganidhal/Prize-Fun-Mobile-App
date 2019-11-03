import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:fun_prize/model/game_engine.dart';

enum CharacterMode {
  IDLE,
  RUNNING,
  JUMPING
}

class CharacterComponent extends PositionComponent {
  static final int _kRunningSpriteFrames = 5;
  static final int _kJumpingSpriteFrames = 7;
  static final int _kIdleSpriteFrames = 21;

  final GameEngine engine;
  CharacterMode mode = CharacterMode.IDLE;
  Anchor anchor = Anchor.bottomLeft;

  final List<Sprite> _runningSprite = List.generate(_kRunningSpriteFrames, (i) => i)
    .map((index) => "character/running/$index.png")
    .map((png) => Sprite(png))
    .toList();
  final List<Sprite> _jumpingSprite = List.generate(_kJumpingSpriteFrames, (i) => i)
    .map((index) => "character/jumping/$index.png")
    .map((png) => Sprite(png))
    .toList();
  final List<Sprite> _idleSprite = List.generate(_kIdleSpriteFrames, (i) => i)
    .map((index) => "character/idle/$index.png")
    .map((png) => Sprite(png))
    .toList();
  int _frame = 0;

  CharacterComponent({this.engine});
  
  void resize(Size size) {
    width = size.width / 10;
    height = size.height / 10;
    x = 0;
    y = height;
  }

  void render(Canvas canvas) {
    switch (mode) {
      case CharacterMode.IDLE:
        _renderIdle(canvas);
        break;
      case CharacterMode.RUNNING:
        _renderRunning(canvas);
        break;
      case CharacterMode.JUMPING:
        _renderJumping(canvas);
        break;
    }
  }

  void update(double time) {
    _frame += 1;
  }

  void _renderIdle(Canvas canvas) {
    _idleSprite[_frame % _kIdleSpriteFrames].renderRect(canvas, Rect.fromLTWH(x, y, width, height));
  }

  void _renderRunning(Canvas canvas) {
    _runningSprite[_frame % _kRunningSpriteFrames].renderRect(canvas, Rect.fromLTWH(x, y, width, height));
  }

  void _renderJumping(Canvas canvas) {
    _jumpingSprite[_frame % _kJumpingSpriteFrames].renderRect(canvas, Rect.fromLTWH(x, y, width, height));
  }
}