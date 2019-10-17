import 'package:bloc/bloc.dart';
import 'package:fun_prize/blocs/game/game_event.dart';
import 'package:fun_prize/blocs/game/game_state.dart';


class GameBloc extends Bloc<GameEvent, GameState> {

  @override
  GameState get initialState => GameState();

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {

  }

}