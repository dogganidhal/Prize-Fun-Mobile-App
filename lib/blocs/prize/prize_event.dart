import 'package:equatable/equatable.dart';
import 'package:fun_prize/model/prize_category.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PrizeEvent extends Equatable {

}

class ClearCategoriesEvent extends PrizeEvent {
  @override
  List<Object> get props => [];
}

class ToggleCategoryFilterEvent extends PrizeEvent {
  final PrizeCategory category;

  ToggleCategoryFilterEvent({this.category});

  @override
  List<Object> get props => [category];
}