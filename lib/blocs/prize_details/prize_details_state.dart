

class PrizeDetailsState {
  bool didPostScore = false;

  PrizeDetailsState get copy => PrizeDetailsState()
    ..didPostScore = didPostScore;
}