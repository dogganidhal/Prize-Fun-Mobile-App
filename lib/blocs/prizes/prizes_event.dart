import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PrizesEvent extends Equatable {
  PrizesEvent([List props]) : super(props);
}

class LoadPrizesEvent extends PrizesEvent {

}