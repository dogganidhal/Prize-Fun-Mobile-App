import 'package:fun_prize/model/prize_winner.dart';
import 'package:meta/meta.dart';


@immutable
class PrizeStanding {
  final PrizeWinner first;
  final PrizeWinner second;
  final PrizeWinner third;

  PrizeStanding({this.first, this.second, this.third});
}