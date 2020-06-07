import 'package:equatable/equatable.dart';

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

class FunPointPlayEvent extends FunPointEvent {
  @override
  List<Object> get props => [];
}