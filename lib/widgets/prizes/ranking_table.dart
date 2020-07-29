import 'package:flutter/material.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/model/prize_participation.dart';
import 'package:fun_prize/model/rankings.dart';
import 'package:fun_prize/model/user.dart';
import 'package:fun_prize/service/prize_service.dart';


class RankingTable extends StatefulWidget {
  final Prize prize;
  final Future<User> userFuture;

  const RankingTable({Key key, this.prize, this.userFuture}) : super(key: key);

  @override
  _RankingTableState createState() => _RankingTableState();
}

class _RankingTableState extends State<RankingTable> {
  Stream<Rankings> rankingStream;

  @override
  void initState() {
    super.initState();
    rankingStream = PrizeService().rankings(widget.prize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(widget.prize.title),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1)
        ),
      ),
      body: StreamBuilder<Rankings>(
        stream: rankingStream,
        builder: (context, rankingSnapshot) {
          if (rankingSnapshot.connectionState == ConnectionState.waiting || rankingSnapshot.data == null)
            return Center(
              child: CircularProgressIndicator()
            );
          if (rankingSnapshot.hasData)
            return FutureBuilder<User>(
              future: widget.userFuture,
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting || !userSnapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator()
                  );
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: Table(
                    children: <TableRow>[
                      _header(context),
                      ...(rankingSnapshot.data)
                        .map((row) => _row(rankingSnapshot.data, row, userSnapshot.data))
                        .toList()
                    ],
                  ),
                );
              }
            );
          return Container();
        }
      ),
    );
  }

  TableRow _row(Rankings rankings, PrizeParticipation participation, User user) => TableRow(
    children: <Widget>[
      TableCell(
        child: Text(
          "${rankings.indexOf(participation) + 1}",
          textAlign: TextAlign.start,
          style: TextStyle(
            color: participation.uid == user.uid ?
              Theme.of(context).primaryColor :
              Theme.of(context).textTheme.bodyText1.color
          ),
        ),
      ),
      TableCell(
        child: Text(
          participation.user.username,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: participation.uid == user.uid ?
              Theme.of(context).primaryColor :
              Theme.of(context).textTheme.bodyText1.color
          ),
        ),
      ),
      TableCell(
        child: Text(
          participation.score.toString(),
          textAlign: TextAlign.end,
          style: TextStyle(
            color: participation.uid == user.uid ?
              Theme.of(context).primaryColor :
              Theme.of(context).textTheme.bodyText1.color
          ),
        ),
      ),
    ]
  );

  TableRow _header(BuildContext context) => TableRow(
    children: <Widget>[
      TableCell(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "Nº",
            style: Theme.of(context).textTheme.subhead,
            textAlign: TextAlign.start,
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
            textAlign: TextAlign.end,
          ),
        ),
      )
    ]
  );
}