import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/model/user.dart';
import 'package:meta/meta.dart';


@immutable
class PrizeParticipation {
  final String prizeId;
  final String uid;
  final String username;
  final int score;

  final Prize prize;
  final User user;

  PrizeParticipation({
    this.username, this.uid, this.score, this.prizeId,
    this.prize, this.user
  });

  factory PrizeParticipation.fromDocument(DocumentSnapshot document, {Prize prize, User user}) => PrizeParticipation(
    prizeId: document.data["prizeId"],
    score: document.data["score"],
    uid: document.data["uid"],
    username: document.data["username"],
    user: user,
    prize: prize
  );

  Map<String, dynamic> get map => {
    "prizeId": prizeId,
    "score": score,
    "uid": uid,
    "username": username
  };

  @override
  bool operator ==(other) {
    if (other is PrizeParticipation) {
      return prizeId == other.prizeId &&
        uid == other.uid &&
        score == other.score;
    }
    return super == other;
  }

  @override
  int get hashCode => super.hashCode;
}