import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fun_prize/model/prize_participation.dart';


@immutable
class DashboardState extends Equatable {
  final Stream<List<PrizeParticipation>> participations;

  DashboardState({@required this.participations});

  @override
  List<Object> get props => [participations];
}