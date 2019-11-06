import 'dart:math';
import 'package:fun_prize/model/bonus_spec.dart';

class BonusGenerator {
  static final double _kMaxDistanceWithoutBonus = 2000;
  static final List<double> _kBonusYValues = [48, 96];
  static final int _kMaxBonusValue = 120;
  static final int _kMinBonusValue = 5;

  BonusSpec generate(double distance) {
    return BonusSpec.star(
      distance: _randomDistance(distance),
      y: _randomY,
      bonus: _randomBonusValue
    );
  }

  static double _randomDistance(double beginDistance) => Random().nextDouble() * _kMaxDistanceWithoutBonus + beginDistance;
  static double get _randomY => _kBonusYValues[Random().nextInt(_kBonusYValues.length)];
  static int get _randomBonusValue => Random().nextInt(_kMaxBonusValue + _kMinBonusValue) - _kMinBonusValue;
}