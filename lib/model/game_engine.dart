import 'dart:async';
import 'package:fun_prize/model/bonus_spec.dart';
import 'package:fun_prize/model/obstacle_spec.dart';

class Position {
  final double x;
  final double y;

  Position({this.x, this.y});

  factory Position.initial() => Position(x: 0, y: 0);
}

class GameEngine {
  final StreamController<Position> _positionController = StreamController();
  final StreamController<ObstacleSpec> _obstaclesController = StreamController();
  final StreamController<BonusSpec> _bonusController = StreamController();
  final StreamController<double> _speedController = StreamController();

  Stream<ObstacleSpec> _obstacles;
  Stream<ObstacleSpec> get obstacles => _obstacles;

  Stream<BonusSpec> _bonus;
  Stream<BonusSpec> get bonus => _bonus;

  Stream<double> _speed;
  Stream<double> get speed => _speed;

  Stream<Position> _position;
  Stream<Position> get position => _position;

  GameEngine() {
    _position = _positionController.stream.asBroadcastStream();
    _obstacles = _obstaclesController.stream.asBroadcastStream();
    _bonus = _bonusController.stream.asBroadcastStream();
    _speed = _speedController.stream.asBroadcastStream();
  }

  Future<double> start() async {
    var score = 0.0;
    _positionController.add(Position.initial());
    return score;
  }

  dispose() {
    _positionController.close();
    _obstaclesController.close();
    _bonusController.close();
    _speedController.close();
  }
}