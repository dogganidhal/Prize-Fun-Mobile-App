import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_prize/model/prize_standing.dart';
import 'package:meta/meta.dart';

@immutable
class Prize {
  static String _kStandingCollection = "standing";

  final int winnerCount;
  final DateTime dueDate;
  final String imageUrl;
  final String title;
  final String subTitle;
  final String description;
  final int minWinnerPoints;
  final PrizeStanding standing;

  Prize({
    this.winnerCount, this.dueDate, this.imageUrl,
    this.title, this.subTitle, this.description,
    this.minWinnerPoints, this.standing
  });

  factory Prize.fromDocument(DocumentSnapshot document) {
    return Prize(
      winnerCount: document.data["winnerCount"],
      dueDate: _formatTimestamp(document.data["dueDate"] as Timestamp),
      imageUrl: document.data["imageUrl"],
      title: document.data["title"],
      subTitle: document.data["subTitle"],
      description: document.data["description"],
      minWinnerPoints: document.data["minWinnerPoints"]
    );
  }

  static DateTime _formatTimestamp(Timestamp timestamp) => timestamp.toDate();
}