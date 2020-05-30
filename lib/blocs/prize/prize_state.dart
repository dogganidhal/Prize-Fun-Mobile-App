import 'package:equatable/equatable.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/model/user.dart';
import 'package:meta/meta.dart';

@immutable
class PrizeState extends Equatable {
  final Stream<List<Prize>> prizes;
  final List<String> selectedCategoryIds;
  final Future<User> userFuture;

  PrizeState({this.prizes, this.selectedCategoryIds, this.userFuture});

  @override
  List<Object> get props => [prizes, selectedCategoryIds, userFuture];
}