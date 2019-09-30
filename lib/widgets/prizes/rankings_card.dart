import 'package:flutter/material.dart';
import 'package:fun_prize/model/rankings.dart';


class RankingsCard extends StatelessWidget {
  final Rankings rankings;

  const RankingsCard({Key key, this.rankings}) : super(key: key);

  @override
  Widget build(BuildContext context) => Table(
    children: <TableRow>[
      _header(context),
      ..._rankingRows.toList()
    ],
  );

  Iterable<TableRow> get _rankingRows sync* {
    var index = 0;
    for (final participation in rankings) {
      yield TableRow(
        children: <Widget>[
          TableCell(
            child: Text(index.toString()),
          ),
          TableCell(
            child: Text(participation.username),
          ),
          TableCell(
            child: Text(participation.score.toString()),
          )
        ]
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
            style: Theme.of(context).textTheme.subhead
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "Pseudo",
            style: Theme.of(context).textTheme.subhead
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "Score",
            style: Theme.of(context).textTheme.subhead
          ),
        ),
      )
    ]
  );
}