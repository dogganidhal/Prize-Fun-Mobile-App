import 'package:flutter/material.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/model/prize_participation.dart';
import 'package:fun_prize/model/rankings.dart';
import 'package:fun_prize/model/user.dart';


class RankingsCard extends StatelessWidget {
  final Prize prize;
  final Stream<Rankings> rankings;
  final Future<User> userFuture;

  const RankingsCard({Key key, this.prize, this.rankings, this.userFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<Rankings>(
    stream: rankings,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting)
        return Center(
          child: CircularProgressIndicator(),
        );
      if (snapshot.hasData)
        return FutureBuilder<User>(
          future: userFuture,
          builder: (context, userSnapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (_haveScoreToBeat(snapshot.data))
                  ...[
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Score à battre",
                        style: Theme.of(context)
                          .textTheme
                          .headline6,
                      ),
                    ),
                    Table(
                      children: <TableRow>[
                        _header(context),
                        _scoreToBeatRow(snapshot.data)
                      ],
                    ),
                  ],
                if (userSnapshot.hasData && _userDidParticipate(snapshot.data, userSnapshot.data))
                  ...[
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Mon score",
                        style: Theme.of(context)
                          .textTheme
                          .headline6,
                      ),
                    ),
                    Table(
                      children: <TableRow>[
                        _header(context),
                        _userRow(snapshot.data, userSnapshot.data)
                      ],
                    ),
                  ]
              ],
            );
          }
        );
      return Container();
    }
  );

  bool _haveScoreToBeat(Rankings rankings) => rankings.length >= prize.winnerCount;

  bool _userDidParticipate(Rankings rankings, User user) => rankings
    .any((participation) => participation.uid == user.uid);

  TableRow _userRow(Rankings rankings, User user) {
    assert(_userDidParticipate(rankings, user));
    final sortedRankings = List<PrizeParticipation>.from(rankings)
      ..sort((lhs, rhs) => rhs.score - lhs.score);
    final userParticipation = sortedRankings
      .firstWhere((element) => element.uid == user.uid);
    final userPosition = sortedRankings
      .indexWhere((participation) => participation == userParticipation);
    return TableRow(
      children: <Widget>[
        TableCell(
          child: Text(
            (userPosition + 1).toString(),
            textAlign: TextAlign.center,
          ),
        ),
        TableCell(
          child: Text(
            userParticipation.username,
            textAlign: TextAlign.center,
          ),
        ),
        TableCell(
          child: Text(
            userParticipation.score.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      ]
    );
  }

  TableRow _scoreToBeatRow(Rankings rankings) {
    assert(_haveScoreToBeat(rankings));
    final sortedRankings = List<PrizeParticipation>.from(rankings)
      ..sort((lhs, rhs) => rhs.score - lhs.score);
    final participationToBeat = sortedRankings[prize.winnerCount - 1];
    return TableRow(
      children: <Widget>[
        TableCell(
          child: Text(
            (prize.winnerCount).toString(),
            textAlign: TextAlign.center,
          ),
        ),
        TableCell(
          child: Text(
            participationToBeat.username,
            textAlign: TextAlign.center,
          ),
        ),
        TableCell(
          child: Text(
            participationToBeat.score.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      ]
    );
  }

  TableRow _header(BuildContext context) => TableRow(
    children: <Widget>[
      TableCell(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "Nº",
            style: Theme.of(context).textTheme.subhead,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "Pseudo",
            style: Theme.of(context).textTheme.subhead,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "Score",
            style: Theme.of(context).textTheme.subhead,
            textAlign: TextAlign.center,
          ),
        ),
      )
    ]
  );
}