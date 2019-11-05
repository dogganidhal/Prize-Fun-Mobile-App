import 'dart:async';
import 'dart:math';
import 'package:fun_prize/model/bonus_spec.dart';
import 'package:fun_prize/model/obstacle_generator.dart';
import 'package:fun_prize/model/obstacle_spec.dart';

class Position {
  final double distance;
  final double y;

  Position({this.distance, this.y});

  factory Position.initial() => Position(distance: 0, y: 0);
}

class GameEngine {
  static final double _kInitialSpeed = 400; // pixels per second
  static final double _kSecondsPerFrame = 1 / 30;
  static final double _kMaxJumpHeight = 133;
  static final double _kScorePerSecond = 1;
  static final double _kAcceleration = 1; // Pixel / Seconds ^ 2
  static final double _kMinTimeWithoutRespawn = 1;

  ObstacleGenerator _obstacleGenerator;

  final StreamController<Position> _positionController = StreamController.broadcast();
  final StreamController<ObstacleSpec> _obstaclesController = StreamController.broadcast();
  final StreamController<BonusSpec> _bonusController = StreamController.broadcast();
  final StreamController<bool> _jumpingController = StreamController.broadcast();
  final StreamController<double> _scoreController = StreamController.broadcast();

  Stream<ObstacleSpec> _obstacles;

  Stream<ObstacleSpec> get obstacles => _obstacles;

  Stream<BonusSpec> _bonus;
  Stream<BonusSpec> get bonus => _bonus;

  Stream<Position> _position;
  Stream<Position> get position => _position;

  Stream<bool> _jumping;
  Stream<bool> get jumping => _jumping;

  Stream<double> _score;
  Stream<double> get score => _score;

  bool _isStarted = false;

  double _timeSinceJumpBegin = 0;
  bool __isJumping = false;
  bool get _isJumping => __isJumping;
  set _isJumping(bool value) {
    _jumpingController.add(value);
    __isJumping = value;
  }

  double _lastSpeed = _kInitialSpeed;

  double __lastScore = 0;
  double get _lastScore => __lastScore;
  set _lastScore(double value) {
    _scoreController.add(value);
    __lastScore = value;
  }

  double _distance = 0;
  double _y = 0;
  double _timeSinceRespawn = 0;

  GameEngine() {
    _position = _positionController.stream.asBroadcastStream();
    _obstacles = _obstaclesController.stream.asBroadcastStream();
    _bonus = _bonusController.stream.asBroadcastStream();
    _jumping = _jumpingController.stream.asBroadcastStream();
    _score = _scoreController.stream.asBroadcastStream();
    _obstacleGenerator = ObstacleGenerator(engine: this);
  }

  void start() {
    _isStarted = true;
    _positionController.add(Position.initial());
    _scoreController.add(0);
    _jumpingController.add(false);
  }

  void update(double time) async {
    if (_isStarted) { // Update score and speed, generate obstacles and bonus
      _updateScoreAndSpeed(time);
      _respawnIfNeeded(time);
    }
    if (_isJumping) {
      _timeSinceJumpBegin += time;
      final jumpFrame = (_timeSinceJumpBegin / _kSecondsPerFrame).floor();
      _y = _getJumpY(jumpFrame);
      _positionController.add(Position(y: _y, distance: _distance));
      if (jumpFrame >= 26) {
        _isJumping = false;
      }
    } else {
      _timeSinceJumpBegin = 0;
    }
  }

  dispose() {
    _positionController.close();
    _obstaclesController.close();
    _bonusController.close();
    _scoreController.close();
  }

  void jump() {
    if (_isJumping) return;
    _isJumping = true;
    _timeSinceJumpBegin = 0;
  }

  double _getJumpY(int frame) => _kMaxJumpHeight * (cos((-pi / 13) * frame - pi) + 1) / 2;

  double _computeSpeed(double currentSpeed, double timeDelta) {
    return currentSpeed;
//    return currentSpeed + timeDelta * _kAcceleration;
  }

  void _updateScoreAndSpeed(double time) {
    final score = _lastScore + time * _kScorePerSecond;
    final speed = _computeSpeed(_lastSpeed, time);
    final dx = speed * time;
    _lastScore = score;
    _lastSpeed = speed;
    _distance += dx;
    _timeSinceRespawn += time;
    _positionController.add(Position(y: _y, distance: _distance));
  }

  void _respawnIfNeeded(double time) {
    if (_timeSinceRespawn >= _kMinTimeWithoutRespawn) {
      _obstacleGenerator.generate(_distance)
        .forEach((obstacle) {
          _obstaclesController.add(obstacle);
        });
      _timeSinceRespawn = 0;
    }
  }
}