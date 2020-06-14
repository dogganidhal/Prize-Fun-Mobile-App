import 'package:equatable/equatable.dart';


abstract class NavigationEvent extends Equatable {

}

class ChangeHomeTabNavigationEvent extends NavigationEvent {
  final int homeIndex;

  ChangeHomeTabNavigationEvent({this.homeIndex});

  @override
  List<Object> get props => [homeIndex];
}

class LaunchGameEvent extends NavigationEvent {
  @override
  List<Object> get props => [];
}