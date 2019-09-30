import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';


@immutable
class PrizeParticipation {
  final String prizeId;
  final String uid;
  final String username;
  final int score;

  PrizeParticipation({this.username, this.uid, this.score, this.prizeId});

  factory PrizeParticipation.fromDocument(DocumentSnapshot document) => PrizeParticipation(
    prizeId: document.data["prizeId"],
    score: document.data["score"],
    uid: document.data["uid"],
    username: document.data["username"]
  );
}