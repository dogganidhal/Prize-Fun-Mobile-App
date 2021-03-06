import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:fun_prize/service/auth_service.dart';
import 'package:fun_prize/service/prize_service.dart';
import 'package:meta/meta.dart';
import 'package:fun_prize/blocs/prize_details/prize_details_event.dart';
import 'package:fun_prize/blocs/prize_details/prize_details_state.dart';
import 'package:fun_prize/model/prize.dart';

class PrizeDetailsBloc extends Bloc<PrizeDetailsEvent, PrizeDetailsState> {
  final Prize prize;
  final AuthService authService = AuthService();
  final PrizeService prizesService = PrizeService();

  PrizeDetailsBloc({@required this.prize});

  @override
  PrizeDetailsState get initialState => PrizeDetailsState()
    ..rankings = prizesService.rankings(prize)
    ..userFuture = authService.loadCurrentUser();

  @override
  Stream<PrizeDetailsState> mapEventToState(PrizeDetailsEvent event) async* {
    if (event is PostScoreEvent) {
      final user = await this.authService.currentUser();
      await prizesService.postScore(event.score, prize, user);
      yield state.copy
        ..didPostScore = true;
      yield state.copy
        ..didPostScore = false;
    }
  }
}