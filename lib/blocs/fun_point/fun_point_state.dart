import 'package:equatable/equatable.dart';
import 'package:fun_prize/model/user.dart';


abstract class FunPointState extends Equatable {

}

class FunPointReadyState extends FunPointState {
  final bool canClaimFunPoint;
  final User user;

  FunPointReadyState({this.canClaimFunPoint = false, this.user});

  @override
  List<Object> get props => [canClaimFunPoint];
}

class FunPointLoadingState extends FunPointState {
  @override
  List<Object> get props => [];
}

