import 'package:equatable/equatable.dart';
import 'package:fun_prize/model/prize_category.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PrizesEvent extends Equatable {

}

class ClearCategoriesEvent extends PrizesEvent {
  @override
  List<Object> get props => [];
}

class ToggleCategoryFilterEvent extends PrizesEvent {
  final PrizeCategory category;

  ToggleCategoryFilterEvent({this.category});

  @override
  List<Object> get props => [category];
}