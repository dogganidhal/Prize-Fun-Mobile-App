import 'package:bloc/bloc.dart';
import 'package:flutter_unity/flutter_unity.dart';
import 'package:fun_prize/blocs/game/game_event.dart';
import 'package:fun_prize/blocs/game/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  UnityViewController _unityViewController;

  @override
  GameState get initialState => GameState();

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {

    if (event is UnityGameCreatedEvent) {
      _unityViewController = event.controller;
      _unityViewController.send(
        'Game',
        'SetTargetScore',
        '${event.prize.rankings[event.prize.targetPosition].score}'
      );
    }

    if (event is UnityMessageReceivedEvent) {
      // TODO: post score and pop back
    }

  }

}