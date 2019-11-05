import 'dart:io';
import 'dart:math';
import 'package:fun_prize/model/game_engine.dart';
import 'package:fun_prize/model/obstacle_spec.dart';

enum ObstacleGeneratorDifficulty {
  EASY,
  MEDIUM,
  HARD
}

class ObstacleGenerator {
  static final double _kStartPoint = 450;
  static final double _kSafeDistance = 250;
  static final double _kMaxDistanceWithoutObstacle = 600;
  static final int _kMaxGluedObstacles = 3;

  final GameEngine engine;

  double _distance = 0;

  ObstacleGenerator({this.engine}) {
    engine.position
      .map((position) => position.distance)
      .listen((distance) => _distance = distance);
  }

  Iterable<ObstacleSpec> generate(double distance, [ObstacleGeneratorDifficulty difficulty]) sync* {
    Iterable<ObstacleSpec> _generateMultiple(double lastGeneratedAt) sync* {
      int obstacleCount = Random().nextInt(_kMaxGluedObstacles) + 1;
      double startDistance = Random().nextDouble() * (_kMaxDistanceWithoutObstacle - _kSafeDistance) + lastGeneratedAt + _kSafeDistance;
      for (var i = 0; i < obstacleCount; i++) {
        final obstacle = ObstacleSpec.standardBox(distance: startDistance);
        startDistance += obstacle.width;
        yield obstacle;
      }
    }
    ObstacleSpec _generateSingle(double lastGeneratedAt) {
      double d = Random().nextDouble() * (_kMaxDistanceWithoutObstacle - _kSafeDistance) + lastGeneratedAt + _kSafeDistance;
      return ObstacleSpec.standardBox(distance: d);
    }
    Map<int, Function> _generators = {
      0: _generateSingle,
      1: _generateMultiple
    };

    Function _generator = _generators[Random().nextInt(_generators.length)];
    dynamic generated = _generator(distance + 800);
    if (generated is ObstacleSpec) {
      yield generated;
    }
    if (generated is Iterable<ObstacleSpec>) {
      for (final generatedObstacle in generated) {
        yield generatedObstacle;
      }
    }
  }
}