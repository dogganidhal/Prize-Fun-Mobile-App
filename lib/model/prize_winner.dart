import 'package:meta/meta.dart';


@immutable
class PrizeWinner {
  final String userId;
  final String points;

  PrizeWinner({this.userId, this.points});
}