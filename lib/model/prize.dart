import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_prize/model/rankings.dart';
import 'package:meta/meta.dart';

@immutable
class Prize {
  final int winnerCount;
  final DateTime dueDate;
  final String imageUrl;
  final String title;
  final String subTitle;
  final String description;
  final int minWinnerPoints;
  final Rankings rankings;

  Prize({
    this.winnerCount, this.dueDate, this.imageUrl,
    this.title, this.subTitle, this.description,
    this.minWinnerPoints, this.rankings
  });

  factory Prize.fromDocument(DocumentSnapshot document, List<DocumentSnapshot> rankings) => Prize(
    winnerCount: document.data["winnerCount"],
    dueDate: _formatTimestamp(document.data["dueDate"] as Timestamp),
    imageUrl: document.data["imageUrl"],
    title: document.data["title"],
    subTitle: document.data["subTitle"],
    description: document.data["description"],
    minWinnerPoints: document.data["minWinnerPoints"],
    rankings: Rankings.fromDocumentList(rankings)
  );

  static DateTime _formatTimestamp(Timestamp timestamp) => timestamp.toDate();
}