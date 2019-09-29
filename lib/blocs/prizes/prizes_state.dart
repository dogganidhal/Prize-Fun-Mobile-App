import 'package:fun_prize/model/prize.dart';


class PrizesState {
  bool isLoading;
  List<Prize> prizes;

  PrizesState({
    this.isLoading = false, this.prizes = const []
  });

  PrizesState get copy => PrizesState(
    isLoading: this.isLoading,
    prizes: this.prizes
  );
}