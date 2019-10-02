import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_prize/model/prize_participation.dart';


class Rankings extends ListBase<PrizeParticipation> {
  final List<PrizeParticipation> _winners;

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
}