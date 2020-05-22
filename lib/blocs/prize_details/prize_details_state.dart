import 'package:fun_prize/model/rankings.dart';
import 'package:fun_prize/model/user.dart';


class PrizeDetailsState {
  bool didPostScore = false;
  Stream<Rankings> rankings;
  Future<User> userFuture;

  PrizeDetailsState get copy => PrizeDetailsState()
    ..didPostScore = didPostScore;
}