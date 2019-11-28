import 'package:bloc/bloc.dart';
import 'package:fun_prize/blocs/prizes/prizes_event.dart';
import 'package:fun_prize/blocs/prizes/prizes_state.dart';
import 'package:fun_prize/service/prizes_service.dart';


class PrizesBloc extends Bloc<PrizesEvent, PrizesState> {
  PrizesService _prizesService = PrizesService();

  @override
  PrizesState get initialState => PrizesState()
    ..prizes =_prizesService.prizes;

  @override
  Stream<PrizesState> mapEventToState(PrizesEvent event) async* {

  }

}