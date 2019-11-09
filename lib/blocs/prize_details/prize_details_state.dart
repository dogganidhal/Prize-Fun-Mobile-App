

class PrizeDetailsState {
  bool isPostingScore = false;

  PrizeDetailsState get copy => PrizeDetailsState()
    ..isPostingScore = isPostingScore;
}