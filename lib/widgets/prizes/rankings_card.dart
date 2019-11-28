import 'package:flutter/material.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/model/rankings.dart';


class RankingsCard extends StatelessWidget {
  final Prize prize;
  final Stream<Rankings> rankings;

  const RankingsCard({Key key, this.prize, this.rankings}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<Rankings>(
    stream: rankings,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting)
        return Center(
          child: CircularProgressIndicator(),
        );
      if (snapshot.hasData)
        return Table(
          children: <TableRow>[
            _header(context),
            ..._rankingRows(snapshot.data)
              .toList()
          ],
        );
      return Container();
    }
  );

  Iterable<TableRow> _rankingRows(Rankings rankings) sync* {
    var index = 0;
    for (final participation in rankings) {
      yield TableRow(
        children: <Widget>[
          TableCell(
            child: Text(
              (index + 1).toString(),
              textAlign: TextAlign.center,
            ),
          ),
          TableCell(
            child: Text(
              participation.username,
              textAlign: TextAlign.center,
            ),
          ),
          TableCell(
            child: Text(
              participation.score.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
      if (prize.isLastWinner(index))
        yield TableRow(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Dernier gagnant",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(color: Colors.grey,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(color: Colors.grey),
            )
          ],
        );
      index++;
    }
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