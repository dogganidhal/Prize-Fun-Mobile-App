import 'package:equatable/equatable.dart';


abstract class GameEvent with EquatableMixin {

}

class DragLeftEvent extends GameEvent {
  @override
  List<Object> get props => [];
}

class DragRightEvent extends GameEvent {
  @override
  List<Object> get props => [];
}

class DragTopEvent extends GameEvent {
  @override
  List<Object> get props => [];
}

class DragBottomEvent extends GameEvent {
  @override
  List<Object> get props => [];
}