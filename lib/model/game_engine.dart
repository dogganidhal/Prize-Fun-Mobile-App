import 'dart:async';
import 'dart:math';
import 'package:fun_prize/model/bonus_generator.dart';
import 'package:fun_prize/model/bonus_spec.dart';
import 'package:fun_prize/model/obstacle_generator.dart';
import 'package:fun_prize/model/obstacle_spec.dart';

enum GameStatus {
  CLEAN,
  HIT_ONCE,
  LOST
}

class Position {
  final double distance;
  final double y;

  Position({this.distance, this.y});

  factory Position.initial() => Position(distance: 0, y: 0);
}

class GameEngine {
  static final double kCharacterWidth = 142;
  static final double kCharacterHeight = 118;

  static final double kCopWidth = 101;
  static final double kCopHeight = 170;

  static final double _kInitialSpeed = 400; // pixels per second
  static final double _kSecondsPerFrame = 1 / 30;
  static final double _kMaxJumpHeight = 133;
  static final double _kScorePerSecond = 1;
  static final double _kAcceleration = 1; // Pixel / Seconds ^ 2
  static final double _kMinTimeWithoutRespawn = 1;

  ObstacleGenerator _obstacleGenerator = ObstacleGenerator();
  BonusGenerator _bonusGenerator = BonusGenerator();

  final StreamController<GameStatus> _statusController = StreamController.broadcast();
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

  Stream<GameStatus> _status;
  Stream<GameStatus> get status => _status;

  List<ObstacleSpec> _obstacleList = [];
  List<BonusSpec> _bonusList = [];

  GameStatus _gameStatus;
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
    _status = _statusController.stream.asBroadcastStream();
    _position.listen((position) {
      _checkObstacles(position);
      _checkBonus(position);
    });
  }

  void start() {
    _isStarted = true;
    _gameStatus = GameStatus.CLEAN;
    _positionController.add(Position.initial());
    _statusController.add(GameStatus.CLEAN);
    _scoreController.add(0);
    _jumpingController.add(false);
  }

  void stop() {
    _isStarted = false;
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
    _statusController.close();
  }

  void jump() {
    if (_isJumping || !_isStarted) return;
    _isJumping = true;
    _timeSinceJumpBegin = 0;
  }

  double _getJumpY(int frame) => _kMaxJumpHeight * (cos((-pi / 13) * frame - pi) + 1) / 2;

  double _computeSpeed(double currentSpeed, double timeDelta) {
    return currentSpeed + timeDelta * _kAcceleration;
  }

  void _updateScoreAndSpeed(double time) {
    if (!_isStarted) return;
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
          _obstacleList.add(obstacle);
          _obstaclesController.add(obstacle);
        });
      final bonus = _bonusGenerator.generate(_distance);
      _bonusList.add(bonus);
      _bonusController.add(bonus);
      _timeSinceRespawn = 0;
    }
  }

  void _checkBonus(Position position) {
    try {
      final bonus = _bonusList
        .where((bonus) => bonus.distance >= position.distance)
        .firstWhere((bonus) => _gotBonus(bonus, position));
      bonus.visible = false;
      _bonusList.remove(bonus);
//      print("Got Bonus(${bonus.distance}, ${bonus.distance + bonus.width},"
//        "${bonus.y}, ${bonus.y + bonus.height})\n"
//        "While in Position(${position.distance}, ${position.distance + kCharacterWidth}, ${position.y}, ${position.y + kCharacterHeight})");
      _lastScore = _lastScore + bonus.value;
    } catch (_) {

    }
  }

  void _checkObstacles(Position position) {
    try {
      final obstacle = _obstacleList
        .where((obstacle) => obstacle.distance >= position.distance)
        .firstWhere((obstacle) => _ranIntoObstacle(obstacle, position));
//      print("Collided with Obstacle(${obstacle.distance}, ${obstacle.distance + obstacle.width},"
//        "0, ${obstacle.height})\n"
//        "While in Position(${position.distance}, ${position.distance + kCharacterWidth}, ${position.y}, ${position.y + kCharacterHeight})");
      _obstacleList.remove(obstacle);
      switch (_gameStatus) {
        case GameStatus.CLEAN:
          _gameStatus = GameStatus.HIT_ONCE;
          _statusController.add(GameStatus.HIT_ONCE);
          break;
        case GameStatus.HIT_ONCE:
          _gameStatus = GameStatus.LOST;
          _statusController.add(GameStatus.LOST);
          break;
        case GameStatus.LOST:
          stop();
          break;
      }
    } catch (_) {
      // Didn't collide with any obstacle
    }
  }

  bool _gotBonus(BonusSpec bonus, Position position) {
    final characterDistance = position.distance + kCharacterWidth * 0.375;
    final characterY = position.y + kCharacterHeight * 0.065 + bonus.height / 2;
    final characterEndDistance = characterDistance + kCharacterWidth * 0.41;
    final characterEndY = characterY + kCharacterHeight * 0.88;
    final points = [
      [characterDistance, characterY],
      [characterEndDistance, characterY],
      [characterDistance, characterEndY],
      [characterEndDistance, characterEndY]
    ];
    return points.any((point) {
      return bonus.distance <= point[0] && bonus.distance + bonus.width >= point[0] &&
        bonus.y <= point[1] && bonus.y + bonus.height >= point[1];
    });
  }

  bool _ranIntoObstacle(ObstacleSpec spec, Position position) {
    final characterDistance = position.distance + kCharacterWidth * 0.375;
    final characterY = position.y + kCharacterHeight * 0.065 + spec.height / 2;
    final characterEndDistance = characterDistance + kCharacterWidth * 0.41;
    return ((position.distance - characterDistance).abs() < 5 ||
      (characterEndDistance - spec.distance - spec.width).abs() < 5) &&
      (characterY <= spec.height);
  }
}