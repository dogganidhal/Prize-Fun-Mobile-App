import 'package:bloc/bloc.dart';
import 'package:fun_prize/service/auth_service.dart';
import 'package:fun_prize/service/prizes_service.dart';
import 'package:meta/meta.dart';
import 'package:fun_prize/blocs/prize_details/prize_details_event.dart';
import 'package:fun_prize/blocs/prize_details/prize_details_state.dart';
import 'package:fun_prize/model/prize.dart';

class PrizeDetailsBloc extends Bloc<PrizeDetailsEvent, PrizeDetailsState> {
  final Prize prize;
  final AuthService authService;
  final PrizesService prizesService;

  PrizeDetailsBloc({@required this.prize, @required this.authService, @required this.prizesService});

  @override
  PrizeDetailsState get initialState => PrizeDetailsState();

  @override
  Stream<PrizeDetailsState> mapEventToState(PrizeDetailsEvent event) async* {
    if (event is PostScoreEvent) {
      yield currentState.copy
        ..isPostingScore = true;
      final user = await this.authService.currentUser();
      assert(user != null);
      await prizesService.postScore(event.score, prize, user);
      yield currentState.copy
        ..isPostingScore = false;
    }
  }

}