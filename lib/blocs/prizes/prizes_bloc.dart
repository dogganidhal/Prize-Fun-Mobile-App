import 'package:bloc/bloc.dart';
import 'package:fun_prize/blocs/prizes/prizes_event.dart';
import 'package:fun_prize/blocs/prizes/prizes_state.dart';
import 'package:fun_prize/service/prizes_service.dart';


class PrizesBloc extends Bloc<PrizesEvent, PrizesState> {
  PrizesService _prizesService = PrizesService();

  @override
  PrizesState get initialState => PrizesState();

  @override
  Stream<PrizesState> mapEventToState(PrizesEvent event) async* {
    final state = this.currentState;

    if (event is LoadPrizesEvent) {
      yield state.copy
        ..isLoading = true;
      final prizes = await _prizesService.getPrizes();
      yield state.copy
        ..isLoading = false
        ..prizes = prizes;
    }

  }

}