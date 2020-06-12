import 'package:equatable/equatable.dart';
import 'package:fun_prize/model/user.dart';


abstract class FunPointState extends Equatable {

}

class FunPointReadyState extends FunPointState {
  final bool canClaimFunPoint;
  final User user;
  final bool prizeUnlocked;

  FunPointReadyState({
    this.user,
    this.canClaimFunPoint = false,
    this.prizeUnlocked = false
  });

  @override
  List<Object> get props => [user, canClaimFunPoint, prizeUnlocked];
}

class FunPointLoadingState extends FunPointState {
  @override
  List<Object> get props => [];
}

