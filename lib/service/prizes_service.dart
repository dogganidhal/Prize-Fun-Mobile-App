import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/model/prize_participation.dart';
import 'package:fun_prize/model/rankings.dart';

class PrizesService {
  static String _kUsersCollection = "users";
  static String _kPrizesCollection = "prizes";
  static String _kRankingsCollection = "rankings";
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
    .asyncMap((futures) => Future.wait(futures));

  Stream<Rankings> rankings(Prize prize) => _firestore.collection(_kRankingsCollection)
    .where(_kRankingsCollection_PrizeIdField, isEqualTo: prize.id)
    .snapshots()
    .map((snapshot) => Rankings.fromDocumentList(snapshot.documents));

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

  Future<Null> _postRankingSubmit(Prize prize, FirebaseUser user) async {
    final rankingSnapshots = await _firestore
      .collection(_kRankingsCollection)
      .where(_kRankingsCollection_PrizeIdField, isEqualTo: prize.id)
      .getDocuments();
    final rankings = Rankings.fromDocumentList(rankingSnapshots.documents);
    final minWinnerScore = rankings[min(rankings.length, prize.winnerCount) - 1].score;
    _firestore
      .collection(_kPrizesCollection)
      .document(prize.id)
      .setData({
        "minWinnerScore": minWinnerScore
      }, merge: true);

    await _removeRedundantRankingsIfNeeded(rankingSnapshots, user.uid);
  }

  Future<Null> _removeRedundantRankingsIfNeeded(QuerySnapshot rankingSnapshot, String uid) async {
    final rankingWithMaxScore = rankingSnapshot.documents
      .reduce((max, rankingDoc) => max.data["score"] < rankingDoc.data["score"] ? rankingDoc : max);
    rankingSnapshot.documents
      .where((document) => document.documentID != rankingWithMaxScore.documentID)
      .forEach((document) => document.reference.delete());
  }
}