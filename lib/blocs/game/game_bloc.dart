import 'package:bloc/bloc.dart';
import 'package:fun_prize/blocs/game/game_event.dart';
import 'package:fun_prize/blocs/game/game_state.dart';
import 'package:fun_prize/widgets/game/prize_fun_game.dart';


class GameBloc extends Bloc<GameEvent, GameState> {

  PrizeFunGame _game = PrizeFunGame();

  @override
  GameState get initialState => GameState();

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {



  }

  @override
  void dispose() {
    _game.dispose();
    super.dispose();
  }

}