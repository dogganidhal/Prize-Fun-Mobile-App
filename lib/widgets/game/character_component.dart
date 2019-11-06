import 'dart:ui';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/sprite.dart';
import 'package:fun_prize/model/game_engine.dart';

enum CharacterMode {
  IDLE,
  RUNNING,
  JUMPING
}

class CharacterComponent extends AnimationComponent {
  static final double _kTimePerFrame = 1 / 30;
  static final int _kRunningSpriteFrames = 18;
  static final int _kJumpingSpriteFrames = 27;
  static final int _kIdleSpriteFrames = 22;
  static final int _kDeadSpriteFrames = 15;

  final GameEngine engine;

  bool _didChangeMode = true;
  CharacterMode _mode = CharacterMode.RUNNING;

  CharacterMode get mode => _mode;
  set mode(CharacterMode value) {
    _didChangeMode = true;
    _mode = value;
  }

  static final List<Frame> _runningFrames = List.generate(_kRunningSpriteFrames, (i) => i)
    .map((index) => "character/running/$index.png")
    .map((png) => Sprite(png))
    .map((sprite) => Frame(sprite, _kTimePerFrame))
    .toList();
  static final List<Frame> _jumpingFrames = List.generate(_kJumpingSpriteFrames, (i) => i)
    .map((index) => "character/jumping/$index.png")
    .map((png) => Sprite(png))
    .map((sprite) => Frame(sprite, _kTimePerFrame))
    .toList();
  static final List<Frame> _idleFrames = List.generate(_kIdleSpriteFrames, (i) => i)
    .map((index) => "character/idle/$index.png")
    .map((png) => Sprite(png))
    .map((sprite) => Frame(sprite, _kTimePerFrame))
    .toList();
  static final List<Frame> _deadFrames = List.generate(_kDeadSpriteFrames, (i) => i)
    .map((index) => "character/dying/$index.png")
    .map((png) => Sprite(png))
    .map((sprite) => Frame(sprite, _kTimePerFrame))
    .toList();

  bool _isDead = false;

  CharacterComponent(this.engine) : super(0, 0, Animation(_runningFrames)) {
    width = GameEngine.kCharacterWidth;
    height = GameEngine.kCharacterHeight;
    x = width;
    engine.jumping.listen((jumping) {
      if (!_isDead) {
        if (jumping) {
          mode = CharacterMode.JUMPING;
        } else {
          mode = CharacterMode.RUNNING;
        }
      }
    });
    engine.status.listen((status) {
      if (status == GameStatus.LOST) {
        _isDead = true;
        animation = Animation(_deadFrames, loop: false);
      }
    });
  }

  @override
  void update(double time) {
    if (_didChangeMode) {
      switch(mode) {
        case CharacterMode.IDLE:
        animation = Animation(_idleFrames);
          break;
        case CharacterMode.RUNNING:
          animation = Animation(_runningFrames);
          break;
        case CharacterMode.JUMPING:
          animation = Animation(_jumpingFrames);
          break;
      }
      _didChangeMode = false;
    }
    super.update(time);
  }
}