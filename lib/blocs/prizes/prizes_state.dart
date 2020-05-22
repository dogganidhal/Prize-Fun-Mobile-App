import 'package:equatable/equatable.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:meta/meta.dart';

@immutable
class PrizesState extends Equatable {
  final Stream<List<Prize>> prizes;
  final List<String> selectedCategoryIds;

  PrizesState({this.prizes, this.selectedCategoryIds});

  @override
  List<Object> get props => [prizes, selectedCategoryIds];
}