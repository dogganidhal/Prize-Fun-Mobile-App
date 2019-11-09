import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fun_prize/model/game_engine.dart';

class _TapEnabledComponent extends PositionComponent with Tapable {
  final Sprite sprite;
  final VoidCallback onTap;

  _TapEnabledComponent({this.sprite, this.onTap});

  @override
  void onTapDown(TapDownDetails details) {
    onTap();
  }

  @override
  void onTapUp(TapUpDetails details) {
    onTap();
  }

  @override
  void render(Canvas c) {
    sprite.renderRect(c, Rect.fromLTWH(x, y, width, height));
  }

  @override
  void update(double t) { }
}


class RecapComponent extends PositionComponent {
  static final Sprite _kOkSprite = Sprite("typography/return.png");
  static final Sprite _kRestartSprite = Sprite("typography/restart.png");

  final GameEngine engine;
  final VoidCallback onOkTapped;
  final VoidCallback onRestartTapped;

  final _TapEnabledComponent _okButton;
  final _TapEnabledComponent _restartButton;

  Anchor anchor = Anchor.center;

  bool _visible = false;
  Rect _backgroundRect = Rect.zero;

  RecapComponent({this.engine, this.onOkTapped, this.onRestartTapped}) :
  _okButton = _TapEnabledComponent(onTap: () => print("OK"), sprite: _kOkSprite),
  _restartButton = _TapEnabledComponent(onTap: () => print("Restart"), sprite: _kRestartSprite) {
    engine.status.listen((status) => _visible = status == GameStatus.LOST);
  }

  @override
  void render(Canvas canvas) {
    if (_visible) {
      canvas.drawRect(_backgroundRect, Paint()
          ..color = Colors.black.withOpacity(0.75)
      );
      _okButton.render(canvas);
      _restartButton.render(canvas);
    }
  }

  @override
  void update(double time) { }

  @override
  void resize(Size size) {
    super.resize(size);
    _backgroundRect = Rect.fromLTWH(0, 0, size.width, size.height);
    _okButton.x = size.width - 281.5 - 32;
    _okButton.y = size.height - 32 - 45;
    _okButton.width = 281.5;
    _okButton.height = 45;

    _restartButton.x = 32;
    _restartButton.y = size.height - 32 - 58;
    _restartButton.width = 293.5;
    _restartButton.height = 58;
  }
}