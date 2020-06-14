import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
  final BuildContext context;

  FunPointUnlockOrPlayPrizeEvent({this.prize, this.context});

  @override
  List<Object> get props => [prize, context];
}