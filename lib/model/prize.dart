import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_prize/model/rankings.dart';
import 'package:meta/meta.dart';

@immutable
class Prize {
  final String id;
  final int winnerCount;
  final DateTime dueDate;
  final DateTime startDate;
  final String imageUrl;
  final String title;
  final String subTitle;
  final String description;
  final int minWinnerScore;
  final Rankings rankings;
  final String categoryId;
  final String prizeRules;
  final String merchantWebsite;

  bool get closed => this.dueDate.compareTo(DateTime.now()) <= 0;

  bool isLastWinner(int index) => (index == this.rankings.length - 1 && this.winnerCount > this.rankings.length) ||
    index == this.winnerCount - 1;

  int get targetPosition {
    if (rankings.length < winnerCount)
      return 0;
    return rankings[winnerCount - 1].score;
  }

  Prize({
    this.winnerCount, this.dueDate, this.imageUrl,
    this.title, this.subTitle, this.description,
    this.minWinnerScore, this.rankings, this.id,
    this.categoryId, this.merchantWebsite, this.prizeRules,
    this.startDate
  });

  factory Prize.fromDocument(DocumentSnapshot document, [List<DocumentSnapshot> rankings]) => Prize(
    id: document.documentID,
    winnerCount: document.data["winnerCount"].toString() == "NaN" ? 0 : document.data["winnerCount"],
    dueDate: _formatTimestamp(document.data["dueDate"] as Timestamp),
    startDate: document.data["startDate"] != null ?
      _formatTimestamp(document.data["startDate"] as Timestamp) :
      null,
    imageUrl: document.data["imageUrl"],
    title: document.data["title"],
    subTitle: document.data["subTitle"],
    description: document.data["description"],
    minWinnerScore: document.data["minWinnerScore"] ?? 0,
    categoryId: document.data['categoryId'],
    merchantWebsite: document.data['merchantWebsite'],
    prizeRules: document.data['prizeRules'],
    rankings: rankings != null ? Rankings.fromDocumentList(rankings) : null
  );

  static DateTime _formatTimestamp(Timestamp timestamp) => timestamp.toDate();
}
