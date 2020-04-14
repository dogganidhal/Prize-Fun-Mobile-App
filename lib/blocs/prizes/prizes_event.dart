import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PrizesEvent extends Equatable {

}

class LoadPrizesEvent extends PrizesEvent {
  @override
  List<Object> get props => [];
}