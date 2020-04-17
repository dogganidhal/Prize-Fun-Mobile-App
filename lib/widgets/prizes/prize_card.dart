import 'package:cached_network_image/cached_network_image.dart';
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
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).dividerColor, width: 0.4),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 192,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: prize.imageUrl,
                    fit: BoxFit.cover,
                  )
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: MaterialButton(
                    color: Theme.of(context).primaryColor,
                    disabledColor: Colors.grey,
                    onPressed: prize.closed ?
                      null :
                      onPlayPressed,
                    child: Text("Jouer"),
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
                _winnerCount(context),
                _countdown(context),
                _minWinnerPoints(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _winnerCount(BuildContext context) => Row(
    children: <Widget>[
      Icon(
        Icons.card_giftcard,
        color: Theme.of(context).textTheme.display3.color
      ),
      SizedBox(width: 4),
      Text(
        prize.winnerCount.toString(),
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.display3.color
        ),
      )
    ],
  );

  Widget _countdown(BuildContext context) => Row(
    children: <Widget>[
      Icon(
        Icons.access_time,
        color: Theme.of(context).textTheme.display3.color
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
                color: Theme.of(context).textTheme.display3.color
              ),
            );
          }
          return Container();
        },
      )
    ],
  );

  Widget _minWinnerPoints(BuildContext context) => Row(
    children: <Widget>[
      Icon(
        Icons.fiber_smart_record,
        color: Theme.of(context).textTheme.display3.color
      ),
      SizedBox(width: 4),
      Text(
        "${prize.minWinnerScore} pts",
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.display3.color
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