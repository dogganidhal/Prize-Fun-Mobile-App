import 'package:fun_prize/model/rankings.dart';


class PrizeDetailsState {
  bool didPostScore = false;
  Stream<Rankings> rankings;

  PrizeDetailsState get copy => PrizeDetailsState()
    ..didPostScore = didPostScore;
}