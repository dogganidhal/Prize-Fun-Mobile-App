import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart';
import 'package:fun_prize/model/prize.dart';


class PrizeCard extends StatelessWidget {
  final Prize prize;
  final VoidCallback onPlayPressed;

  const PrizeCard({Key key, @required this.prize, this.onPlayPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 192,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.network(
                    prize.imageUrl,
                    fit: BoxFit.cover,
                  )
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: MaterialButton(
                    color: Colors.amber,
                    onPressed: onPlayPressed,
                    child: Text("Jouer".toUpperCase()),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _winnerCount,
                _countdown,
                _minWinnerPoints
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _winnerCount => Row(
    children: <Widget>[
      Icon(
        Icons.group,
        color: Colors.black38,
      ),
      SizedBox(width: 4),
      Text(
        prize.winnerCount.toString(),
        style: TextStyle(
          fontSize: 16,
          color: Colors.black38
        ),
      )
    ],
  );

  Widget get _countdown => Row(
    children: <Widget>[
      Icon(
        Icons.access_time,
        color: Colors.black38,
      ),
      SizedBox(width: 4),
      StreamBuilder<String>(
        stream: _countdownDuration,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black38
              ),
            );
          }
          return Container();
        },
      )
    ],
  );

  Widget get _minWinnerPoints => Row(
    children: <Widget>[
      Icon(
        Icons.fiber_smart_record,
        color: Colors.black38,
      ),
      SizedBox(width: 4),
      Text(
        "${prize.minWinnerPoints} pts",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black38
        ),
      )
    ],
  );

  Stream<String> get _countdownDuration async* {
    Duration duration = prize.dueDate.difference(DateTime.now());
    while (!duration.isNegative) {

      yield prettyDuration(
        duration,
        tersity: DurationTersity.second,
        abbreviated: true,
        locale: FrenchDurationLocale()
      );
      await Future.delayed(Duration(seconds: 1));
      duration -= Duration(seconds: 1);
    }
    yield "Lot clôturé";
  }
}