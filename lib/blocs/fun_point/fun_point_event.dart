import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:fun_prize/model/prize.dart';

abstract class FunPointEvent extends Equatable {

}

class FunPointLoadEvent extends FunPointEvent {
  @override
  List<Object> get props => [];
}

class FunPointClaimEvent extends FunPointEvent {
  @override
  List<Object> get props => [];
}

class FunPointUnlockOrPlayPrizeEvent extends FunPointEvent {
  final Prize prize;
  final MethodChannel methodChannel;

  FunPointUnlockOrPlayPrizeEvent({this.prize, this.methodChannel});

  @override
  List<Object> get props => [prize, methodChannel];
}