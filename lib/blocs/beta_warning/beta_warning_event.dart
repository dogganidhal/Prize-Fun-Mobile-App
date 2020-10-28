import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fun_prize/model/prize.dart';

abstract class BetaWarningEvent extends Equatable {

}

class LoadBetaWarningEvent extends BetaWarningEvent {
  @override
  List<Object> get props => [];
}
