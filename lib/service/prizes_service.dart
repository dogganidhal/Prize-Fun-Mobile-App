import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/model/prize_participation.dart';
import 'package:fun_prize/utils/concurrent.dart';

class PrizesService {
  static String _kUsersCollection = "users";
  static String _kPrizesCollection = "prizes";
  static String _kRankingsCollection = "rankings";
  // ignore: non_constant_identifier_names
  static String _kRankingsCollection_PrizeIdField = "prizeId";
  // ignore: non_constant_identifier_names
  static String _kUsersCollection_UsernameField = "username";

  final Firestore _firestore = Firestore.instance;

  Future<List<Prize>> getPrizes() async {
    final snapshot = await _firestore.collection(_kPrizesCollection)
      .getDocuments();
    final futures = snapshot.documents
      .map((prizeDoc) async {
        final rankingsSnapshot = await delayed(_firestore.collection(_kRankingsCollection)
          .where(_kRankingsCollection_PrizeIdField, isEqualTo: prizeDoc.documentID)
          .getDocuments());
        return Prize.fromDocument(prizeDoc, rankingsSnapshot.documents);
      });
    return await Future.wait(futures);
  }

  Future<Null> postScore(double score, Prize prize, FirebaseUser user) async {
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
  }
}