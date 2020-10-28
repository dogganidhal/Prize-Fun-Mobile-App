import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/navigation/event/navigation_event.dart';
import 'package:fun_prize/blocs/navigation/navigation_bloc.dart';
import 'package:fun_prize/blocs/navigation/state/navigation_state.dart';
import 'package:fun_prize/widgets/beta_warning/beta_warning_listener.dart';
import 'package:fun_prize/widgets/dashboard/dashboard.dart';
import 'package:fun_prize/widgets/fun_points/daily_fun_point_listener.dart';
import 'package:fun_prize/widgets/fun_points/fun_points.dart';
import 'package:fun_prize/widgets/prizes/prizes.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) => BetaWarningListener(
        child: DailyFunPointListener(
          child: Scaffold(
            body: IndexedStack(
              index: state.homeIndex,
              children: <Widget>[
                Prizes(),
                Dashboard(),
                FunPoints()
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              currentIndex: state.homeIndex,
              onTap: (index) => BlocProvider
                .of<NavigationBloc>(context)
                .add(ChangeHomeTabNavigationEvent(homeIndex: index)),
              selectedItemColor: Theme.of(context).primaryColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/gift.png",
                    height: 24,
                    colorBlendMode: BlendMode.srcIn,
                    color: state.homeIndex == 0 ?
                      Theme.of(context).primaryColor :
                      Theme.of(context).unselectedWidgetColor,
                  ),
                  title: Text('Concours')
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/statistics.png",
                    height: 24,
                    colorBlendMode: BlendMode.srcIn,
                    color: state.homeIndex == 1 ?
                      Theme.of(context).primaryColor :
                      Theme.of(context).unselectedWidgetColor,
                  ),
                  title: Text('Tableau de bord')
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/fun-point.png",
                    height: 24,
                    colorBlendMode: BlendMode.srcIn,
                    color: state.homeIndex == 2 ?
                      Theme.of(context).primaryColor :
                      Theme.of(context).unselectedWidgetColor,
                  ),
                  title: Text('Fun points')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
