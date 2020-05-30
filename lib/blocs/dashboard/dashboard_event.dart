import 'package:equatable/equatable.dart';


abstract class DashboardEvent extends Equatable {

}

class LoadUserParticipationsEvent extends DashboardEvent {
  @override
  List<Object> get props => [];
}