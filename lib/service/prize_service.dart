import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/model/prize_category.dart';
import 'package:fun_prize/model/prize_participation.dart';
import 'package:fun_prize/model/rankings.dart';
import 'package:fun_prize/model/user.dart';

class PrizeService {
  static String _kUsersCollection = "users";
  static String _kPrizesCollection = "prizes";
  static String _kRankingsCollection = "rankings";
  static String _kCategoriesCollection = "categories";
  // ignore: non_constant_identifier_names
  static String _kRankingsCollection_PrizeIdField = "prizeId";
  // ignore: non_constant_identifier_names
  static String _kUsersCollection_UsernameField = "username";

  final Firestore _firestore = Firestore.instance;

  Stream<List<Prize>> get prizes => _firestore.collection(_kPrizesCollection)
    .snapshots()
    .map((snapshot) => snapshot.documents
      .map((prizeDoc) async {
        final rankingsSnapshot = await _firestore.collection(_kRankingsCollection)
          .where(_kRankingsCollection_PrizeIdField, isEqualTo: prizeDoc.documentID)
          .getDocuments();
        return Prize.fromDocument(prizeDoc, rankingsSnapshot.documents);
      })
      .toList()
    )
    .asyncMap((futures) => Future.wait(futures))
    .map((prizeList) => prizeList
      .where((element) {
        final yesterday = DateTime.now().subtract(Duration(days: 1));
        final dueDateDiff = DateTime.now().difference(element.dueDate).inDays;
        final startDateDiff = (element.startDate ?? yesterday).difference(DateTime.now()).inDays;
        return dueDateDiff <= 0 && startDateDiff <= 0;
      })
      .toList()
    )
    .map((prizeList) {
      final now = DateTime.now();
      final sortedPrizes = List<Prize>.from(prizeList
        .where((element) => element.dueDate.compareTo(now) > 0)
      );
      sortedPrizes.sort((lhs, rhs) {
        final rhsDiff =  rhs.startDate.difference(now);
        final lhsDiff = lhs.startDate.difference(now);
        return (rhsDiff - lhsDiff).inSeconds;
      });
      sortedPrizes.addAll(prizeList.where((element) => element.dueDate.compareTo(now) <= 0));
      return sortedPrizes;
    });

  Stream<Rankings> rankings(Prize prize) => _firestore.collection(_kRankingsCollection)
    .where(_kRankingsCollection_PrizeIdField, isEqualTo: prize.id)
    .snapshots()
    .asyncMap((snapshot) => snapshot.documents
      .map((participationDocument) async {
        final userDocument = await _firestore
          .document("$_kUsersCollection/${participationDocument.data['uid']}")
          .get();
        final user = User.fromDocument(userDocument);
        return PrizeParticipation.fromDocument(participationDocument, user: user);
      })
      .toList()
    )
    .asyncMap((futures) => Future.wait(futures))
    .map((participations) {
      participations.sort((lhs, rhs) => rhs.score - lhs.score);
      return participations;
    })
    .map((participations) => Rankings.fromParticipations(participations));

  Future<Null> postScore(int score, Prize prize, FirebaseUser user) async {
    final userDocument = await _firestore
      .collection(_kUsersCollection)
      .document(user.uid)
      .get();
    PrizeParticipation participation = PrizeParticipation(
      username: userDocument.data[_kUsersCollection_UsernameField],
      uid: user.uid,
      score: score.toInt(),
      prizeId: prize.id
    );
    await _firestore.collection(_kRankingsCollection)
      .add(participation.map);
    await _postRankingSubmit(prize, user);
  }

  Future<List<PrizeCategory>> get categories async {
    final snapshot = await _firestore.collection(_kCategoriesCollection)
      .getDocuments();
    return snapshot.documents
      .map((document) => PrizeCategory.fromDocument(document))
      .toList();
  }

  Future<Null> _postRankingSubmit(Prize prize, FirebaseUser user) async {
    var rankingSnapshots = await _rankingsForPrize(prize);
    await _removeRedundantRankingsIfNeeded(rankingSnapshots, user.uid);
    rankingSnapshots = await _rankingsForPrize(prize);

    final rankings = Rankings.fromDocumentList(rankingSnapshots.documents);
    final minWinnerScore = rankings.length > prize.winnerCount ?
      rankings[min(rankings.length, prize.winnerCount) - 1].score :
      0;
    _firestore
      .collection(_kPrizesCollection)
      .document(prize.id)
      .setData({
        "minWinnerScore": minWinnerScore
      }, merge: true);
  }

  Future<Null> _removeRedundantRankingsIfNeeded(QuerySnapshot rankingSnapshot, String uid) async {
    final rankingWithMaxScore = rankingSnapshot.documents
      .where((document) => document['uid'] == uid)
      .reduce((max, rankingDoc) => max.data["score"] < rankingDoc.data["score"] ? rankingDoc : max);
    rankingSnapshot.documents
      .where((document) => document.data['uid'] == uid)
      .where((document) => document.documentID != rankingWithMaxScore.documentID)
      .forEach((document) => document.reference.delete());
  }

  Future<QuerySnapshot> _rankingsForPrize(Prize prize) => _firestore
    .collection(_kRankingsCollection)
    .where(_kRankingsCollection_PrizeIdField, isEqualTo: prize.id)
    .getDocuments();
}
