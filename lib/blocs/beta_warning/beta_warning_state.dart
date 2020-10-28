import 'package:equatable/equatable.dart';


abstract class BetaWarningState extends Equatable {

}


class BetaWarningLoadingState extends BetaWarningState {
  @override
  List<Object> get props => [];
}


class BetaWarningReadyState extends BetaWarningState {
  final bool firstOpen;

  BetaWarningReadyState(this.firstOpen);

  @override
  List<Object> get props => [firstOpen];
}
