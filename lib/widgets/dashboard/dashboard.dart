import 'package:cached_network_image/cached_network_image.dart';
import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/dashboard/dashboard_bloc.dart';
import 'package:fun_prize/blocs/dashboard/dashboard_event.dart';
import 'package:fun_prize/blocs/dashboard/dashboard_state.dart';
import 'package:fun_prize/model/prize_participation.dart';
import 'package:fun_prize/widgets/dashboard/profile.dart';
import 'package:fun_prize/widgets/prizes/prize_details.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardBloc _bloc = DashboardBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(LoadUserParticipationsEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text("Tableau de bord"),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1)
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Profile()
            )),
          )
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        bloc: _bloc,
        builder: (context, state) => StreamBuilder<List<PrizeParticipation>>(
          stream: state.participations,
          builder: (context, snapshot) => Stack(
            children: <Widget>[
              if (snapshot.connectionState == ConnectionState.waiting)
                Positioned(
                  top: 0, left: 0, right: 0,
                  height: 4,
                  child: LinearProgressIndicator(),
                ),
              if (snapshot.hasData)
                Positioned.fill(
                  child: ListView.separated(
                    itemBuilder: (context, index) => _participationCard(snapshot.data[index]),
                    separatorBuilder: (context, _) => SizedBox(height: 8),
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.all(8),
                  )
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _participationCard(PrizeParticipation participation) => GestureDetector(
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PrizeDetails(
        prize: participation.prize
      )
    )),
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).dividerColor,
          width: 0.4
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 192,
            child: CachedNetworkImage(
              imageUrl: participation.prize.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Wrap(
                  spacing: 4,
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/clock.png",
                      height: 24,
                      color: Theme.of(context).textTheme.display3.color
                    ),
                    Text(
                      prettyDuration(
                        participation.prize.dueDate.difference(DateTime.now()),
                        tersity: DurationTersity.minute,
                        abbreviated: true,
                        locale: FrenchDurationLocale()
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.display3.color
                      ),
                    )
                  ],
                ),
                Wrap(
                  spacing: 4,
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/target.png",
                      height: 24,
                      color: Theme.of(context).textTheme.display3.color
                    ),
                    Text(
                      "${participation.prize.targetPosition} pts",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.display3.color
                      ),
                    )
                  ],
                ),
                Wrap(
                  spacing: 4,
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/cup.png",
                      height: 24,
                      color: Theme.of(context).textTheme.display3.color
                    ),
                    Text(
                      "${participation.prize.rankings.rankOf(participation)} "
                        "/ ${participation.prize.winnerCount}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.display3.color
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}