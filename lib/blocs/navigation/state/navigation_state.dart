import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class NavigationState extends Equatable {
  final int homeIndex;

  NavigationState({this.homeIndex = 0});

  factory NavigationState.initial() => NavigationState();

  @override
  List<Object> get props => [homeIndex];
}