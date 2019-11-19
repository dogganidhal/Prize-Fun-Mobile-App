import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_prize/model/rankings.dart';
import 'package:meta/meta.dart';

@immutable
class Prize {
  final String id;
  final int winnerCount;
  final DateTime dueDate;
  final String imageUrl;
  final String title;
  final String subTitle;
  final String description;
  final int minWinnerScore;
  final Rankings rankings;

  bool get closed => this.dueDate.compareTo(DateTime.now()) <= 0;

  bool isLastWinner(int index) => (index == this.rankings.length - 1 && this.winnerCount > this.rankings.length) ||
    index == this.winnerCount - 1;

  Prize({
    this.winnerCount, this.dueDate, this.imageUrl,
    this.title, this.subTitle, this.description,
    this.minWinnerScore, this.rankings, this.id
  });

  factory Prize.fromDocument(DocumentSnapshot document, List<DocumentSnapshot> rankings) => Prize(
    id: document.documentID,
    winnerCount: document.data["winnerCount"],
    dueDate: _formatTimestamp(document.data["dueDate"] as Timestamp),
    imageUrl: document.data["imageUrl"],
    title: document.data["title"],
    subTitle: document.data["subTitle"],
    description: document.data["description"],
    minWinnerScore: document.data["minWinnerScore"] ?? 0,
    rankings: Rankings.fromDocumentList(rankings)
  );

  static DateTime _formatTimestamp(Timestamp timestamp) => timestamp.toDate();
}