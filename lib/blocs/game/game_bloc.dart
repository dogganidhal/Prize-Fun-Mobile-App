import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_unity/flutter_unity.dart';
import 'package:fun_prize/blocs/game/game_event.dart';
import 'package:fun_prize/blocs/game/game_state.dart';
import 'package:fun_prize/blocs/navigation/navigation_bloc.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/service/auth_service.dart';
import 'package:fun_prize/service/prize_service.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final Prize prize;
  final NavigationBloc navigationBloc;

  final PrizeService prizeService = PrizeService();
  final AuthService authService = AuthService();

  UnityViewController _unityViewController;

  GameBloc({this.prize, this.navigationBloc});

  @override
  GameState get initialState => GameState();

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {

    if (event is UnityGameCreatedEvent) {
      _unityViewController = event.controller;
      _unityViewController.send(
        'Game',
        'SetTargetScore',
        '${event.prize.minWinnerScore}'
      );
    }

    if (event is UnityMessageReceivedEvent) {
      final message = _UnityMessage.fromJson(event.message);
      if (message is _PostScoreMessage) {
        navigationBloc.pop();
        final user = await this.authService.currentUser();
        await prizeService.postScore(message.score, prize, user);
      }
    }

  }

}

abstract class _UnityMessage {
  static _UnityMessage fromJson(String jsonString) {
    final jsonMap = json.decode(jsonString);
    switch(jsonMap['_type']) {
      case "post_score":
        return _PostScoreMessage.fromJson(jsonMap);
      case "lifecycle":
        return _LifecycleMessage.fromJson(jsonMap);
      default:
        throw Exception("unsupported message type \"${jsonMap['_type']}\"");
    }
  }
}

class _PostScoreMessage extends _UnityMessage {
  final int score;

  _PostScoreMessage({this.score});

  factory _PostScoreMessage.fromJson(Map<String, dynamic> json) => _PostScoreMessage(
    score: int.parse(json['score'])
  );
}

class _LifecycleMessage extends _UnityMessage {
  final String event;

  _LifecycleMessage({this.event});

  factory _LifecycleMessage.fromJson(Map<String, dynamic> json) => _LifecycleMessage(
    event: json['event']
  );
}