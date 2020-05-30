import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_prize/model/prize_participation.dart';


class Rankings extends ListBase<PrizeParticipation> {
  final List<PrizeParticipation> _winners;
  List<PrizeParticipation> _sorted;

  List<PrizeParticipation> get sorted {
    if (_sorted == null) {
      _sorted = List.from(_winners);
      _sorted.sort((lhs, rhs) => rhs.score - lhs.score);
    }
    return _sorted;
  }

  int get length => _winners.length;
  set length(int length) {
    _winners.length = length;
  }

  Rankings._(this._winners);

  factory Rankings.fromDocumentList(List<DocumentSnapshot> documents) =>
    Rankings._(
      documents
        .map((document) => PrizeParticipation.fromDocument(document))
        .toList()
        ..sort((lhs, rhs) => rhs.score - lhs.score)
    );

  PrizeParticipation operator [](int index) => _winners[index];

  @override
  void operator []=(int index, PrizeParticipation value) => _winners[index] = value;

  int rankOf(PrizeParticipation participation) {
    assert(_winners.contains(participation));
    return sorted.indexOf(participation) + 1;
  }
}