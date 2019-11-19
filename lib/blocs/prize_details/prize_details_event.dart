import 'package:equatable/equatable.dart';

class PrizeDetailsEvent with EquatableMixin {
  final List<Object> props;

  PrizeDetailsEvent(this.props);
}

class PostScoreEvent extends PrizeDetailsEvent {
  final int score;

  PostScoreEvent(this.score) : super([score]);
}