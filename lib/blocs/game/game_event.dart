import 'package:equatable/equatable.dart';
import 'package:flutter_unity/flutter_unity.dart';
import 'package:fun_prize/model/prize.dart';


abstract class GameEvent extends Equatable {

}

class UnityGameCreatedEvent extends GameEvent {
  final UnityViewController controller;
  final Prize prize;

  UnityGameCreatedEvent({this.controller, this.prize});

  @override
  List<Object> get props => [controller, prize];
}

class UnityMessageReceivedEvent extends GameEvent {
  final String message;

  UnityMessageReceivedEvent({this.message});

  @override
  List<Object> get props => [message];
}