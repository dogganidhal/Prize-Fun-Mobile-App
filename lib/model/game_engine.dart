import 'dart:async';
import 'dart:math';
import 'package:fun_prize/model/bonus_spec.dart';
import 'package:fun_prize/model/obstacle_spec.dart';

class Position {
  final double x;
  final double y;

  Position({this.x, this.y});

  factory Position.initial() => Position(x: 0, y: 0);
}

class GameEngine {
  static final double _kInitialSpeed = 100; // pixels per second
  static final double _kSecondsPerFrame = 1 / 30;
  static final double _kMaxJumpHeight = 133;

  final StreamController<Position> _positionController = StreamController();
  final StreamController<ObstacleSpec> _obstaclesController = StreamController();
  final StreamController<BonusSpec> _bonusController = StreamController();
  final StreamController<double> _speedController = StreamController();
  final StreamController<bool> _jumpingController = StreamController();

  Stream<ObstacleSpec> _obstacles;
  Stream<ObstacleSpec> get obstacles => _obstacles;

  Stream<BonusSpec> _bonus;
  Stream<BonusSpec> get bonus => _bonus;

  Stream<double> _speed;
  Stream<double> get speed => _speed;

  Stream<Position> _position;
  Stream<Position> get position => _position;

  Stream<bool> _jumping;
  Stream<bool> get jumping => _jumping;

  double _timeSinceJumpBegin = 0;
  bool _isJumping = false;

  GameEngine() {
    _position = _positionController.stream.asBroadcastStream();
    _obstacles = _obstaclesController.stream.asBroadcastStream();
    _bonus = _bonusController.stream.asBroadcastStream();
    _speed = _speedController.stream.asBroadcastStream();
    _jumping = _jumpingController.stream.asBroadcastStream();
  }

  Future<double> start() async {
    var score = 0.0;
    _positionController.add(Position.initial());
    _speedController.add(_kInitialSpeed);
    _jumpingController.add(false);
    return score;
  }

  void update(double time) {
    if (_isJumping) {
      _timeSinceJumpBegin += time;
      final jumpFrame = (_timeSinceJumpBegin / _kSecondsPerFrame).floor();
      final jumpY = _getJumpY(jumpFrame);
      _positionController.add(Position(y: jumpY));
      if (jumpFrame == 26) {
        _isJumping = false;
        _jumpingController.add(false);
      }
    } else {
      _timeSinceJumpBegin = 0;
    }
  }

  dispose() {
    _positionController.close();
    _obstaclesController.close();
    _bonusController.close();
    _speedController.close();
  }

  void jump() {
    if (_isJumping) return;
    _isJumping = true;
    _jumpingController.add(true);
    _timeSinceJumpBegin = 0;
  }

  double _getJumpY(int frame) => _kMaxJumpHeight * (cos((-pi / 13) * frame - pi) + 1) / 2;
}