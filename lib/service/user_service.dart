import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/model/prize_participation.dart';
import 'package:fun_prize/model/user.dart';


class UserService {
  static int _kPrizePrice = 3;
  static int _kDailyFunPointReward = 3;
  static String _kPrizesCollection = "prizes";
  static String _kUsersCollection = "users";
  static String _kRankingsCollection = "rankings";
  // ignore: non_constant_identifier_names
  static String _kRankingsCollection_PrizeIdField = "prizeId";

  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<List<PrizeParticipation>> get userParticipations async* {
    final user = await _firebaseAuth.currentUser();
    final prizeDocuments = await _firestore
      .collection(_kPrizesCollection)
      .getDocuments();
    assert(user != null);
    yield* _firestore
      .collection(_kRankingsCollection)
      .where("uid", isEqualTo: user.uid)
      .snapshots()
      .map((snapshot) => snapshot.documents
        .where((document) => prizeDocuments.documents.any((prizeDocument) => prizeDocument.documentID == document.data['prizeId']))
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
      .asyncMap((future) => Future.wait(future))
      .map((List<PrizeParticipation> participationList) {
        final sortedParticipations = List<PrizeParticipation>.from(participationList
          .where((participation) => participation.prize.dueDate.compareTo(DateTime.now()) > 0)
        );
        sortedParticipations.sort((lhs, rhs) => lhs.prize.dueDate.compareTo(rhs.prize.dueDate));
        sortedParticipations.addAll(
          participationList
            .where((element) => element.prize.dueDate.compareTo(DateTime.now()) <= 0)
        );
        return sortedParticipations;
      });
  }

  Future<void> claimDailyFunPoint(User user) async {
    final snapshot = _firestore
      .collection(_kUsersCollection)
      .document(user.uid);
    await snapshot.setData({
      "funPoints": user.funPoints + _kDailyFunPointReward
    }, merge: true);
  }

  Future<void> unlockPrizeAndBillFunPoints(User user, Prize prize) async {
    final snapshot = _firestore
      .collection(_kUsersCollection)
      .document(user.uid);
    await snapshot.setData({
      "funPoints": user.funPoints - _kPrizePrice,
       "prizeParticipationIds": List.from(user.prizeParticipationIds)
          ..add(prize.id)
    }, merge: true);
  }
}