import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/model/prize_participation.dart';


class UserService {
  static String _kPrizesCollection = "prizes";
  static String _kRankingsCollection = "rankings";
  // ignore: non_constant_identifier_names
  static String _kRankingsCollection_PrizeIdField = "prizeId";

  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<List<PrizeParticipation>> get userParticipations async* {
    final user = await _firebaseAuth.currentUser();
    assert(user != null);
    yield* _firestore
      .collection(_kRankingsCollection)
      .where("uid", isEqualTo: user.uid)
      .snapshots()
      .map((snapshot) => snapshot.documents
        .map((document) async {
          final prizeDocument = await _firestore
            .document("$_kPrizesCollection/${document.data['prizeId']}")
            .get();
          final rankingDocuments = await _firestore.collection(_kRankingsCollection)
            .where(_kRankingsCollection_PrizeIdField, isEqualTo: prizeDocument.documentID)
            .getDocuments();
          return PrizeParticipation.fromDocument(
            document,
            prize: Prize.fromDocument(prizeDocument, rankingDocuments.documents)
          );
        })
        .toList()
      )
      .asyncMap((future) => Future.wait(future));
  }

  Future<List<PrizeParticipation>> loadUserParticipations() async {
    final user = await _firebaseAuth.currentUser();
    assert(user != null);
    final snapshot = await _firestore
      .collection(_kRankingsCollection)
      .where("uid", isEqualTo: user.uid)
      .getDocuments();
    return Future.wait(
      snapshot.documents
        .map((document) async {
          final prizeDocument = await _firestore
            .document("$_kPrizesCollection/${document.data['prizeId']}")
            .get();
          final rankingDocuments = await _firestore.collection(_kRankingsCollection)
            .where(_kRankingsCollection_PrizeIdField, isEqualTo: prizeDocument.documentID)
            .getDocuments();
          return PrizeParticipation.fromDocument(
            document,
            prize: Prize.fromDocument(prizeDocument, rankingDocuments.documents)
          );
        })
    );
  }
}