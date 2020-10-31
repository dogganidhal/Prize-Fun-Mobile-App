import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/model/user.dart';
import 'package:transparent_image/transparent_image.dart';


class PrizeCard extends StatelessWidget {
  final Prize prize;
  final Future<User> userFuture;
  final VoidCallback onPlayPressed;

  const PrizeCard({Key key, @required this.prize, this.userFuture, this.onPlayPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).dividerColor, width: 0.4),
        borderRadius: BorderRadius.circular(4),
      ),
      color: prize.dueDate.difference(DateTime.now()).isNegative ?
        Theme.of(context).disabledColor :
        null,
      child: InkWell(
        onTap: prize.closed ?
          null :
          onPlayPressed,
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                SizedBox(
                  child: AspectRatio(
                    aspectRatio: 16/9,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: prize.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (prize.dueDate.difference(DateTime.now()).isNegative)
                  Positioned.fill(
                    child: Container(
                      color: Theme.of(context).disabledColor,
                    ),
                  )
              ],
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
            )
          ],
        ),
      ),
    );
  }

  Widget _userScore(BuildContext context, User user) => Row(
    children: <Widget>[
      Image.asset(
        "assets/user-score.png",
        width: 24, height: 24,
        color: Theme.of(context).unselectedWidgetColor,
      ),
      SizedBox(width: 4),
      Text(
        "${prize.rankings.scoreOfUser(user)} pts",
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.display3.color
        ),
      )
    ],
  );

  Widget _userPosition(BuildContext context, User user) => Row(
    children: <Widget>[
      Image.asset(
        "assets/cup.png",
        width: 24, height: 24,
        color: Theme.of(context).unselectedWidgetColor,
      ),
      SizedBox(width: 4),
      Text(
        "${prize.rankings.rankOfUser(user)} / ${prize.winnerCount}",
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.display3.color
        ),
      )
    ],
  );

  Widget _winnerCount(BuildContext context) => Row(
    children: <Widget>[
      Image.asset(
        "assets/gift.png",
        width: 20, height: 20,
        color: Theme.of(context).unselectedWidgetColor,
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
      Image.asset(
        "assets/clock.png",
        width: 24, height: 24,
        color: Theme.of(context).unselectedWidgetColor,
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
      Image.asset(
        "assets/target.png",
        height: 24,
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
      yield _formatDuration(duration);
      await Future.delayed(Duration(seconds: 1));
      duration -= Duration(seconds: 1);
    }
    yield "Lot clôturé";
  }

  String _formatDuration (Duration duration) {
    return [duration.inHours, duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
}
