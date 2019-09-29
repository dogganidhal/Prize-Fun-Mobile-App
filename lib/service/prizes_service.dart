import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_prize/model/prize.dart';

class PrizesService {
  static String _kPrizesCollection = "prizes";

  final Firestore _firestore = Firestore.instance;

  Future<List<Prize>> getPrizes() async {
    final snapshot = await _firestore.collection(_kPrizesCollection)
      .getDocuments();
    final prizes = snapshot.documents
      .map((document) => Prize.fromDocument(document))
      .toList();
    return prizes;
  }

}