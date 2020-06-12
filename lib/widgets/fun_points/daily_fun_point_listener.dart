import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_bloc.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_event.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_state.dart';
import 'package:fun_prize/blocs/navigation/event/navigation_event.dart';
import 'package:fun_prize/blocs/navigation/navigation_bloc.dart';

class DailyFunPointListener extends StatefulWidget {
  final Widget child;

  const DailyFunPointListener({Key key, @required this.child}) : super(key: key);

  @override
  _DailyFunPointListenerState createState() => _DailyFunPointListenerState();
}

class _DailyFunPointListenerState extends State<DailyFunPointListener> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<FunPointBloc>(context).add(FunPointLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FunPointBloc, FunPointState>(
      listener: (context, state) {
        if (state is FunPointReadyState && state.canClaimFunPoint) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)
              ),
              title: Text("Fun point quotidien"),
              content: Text(
                  "Bravo!\n"
                  "Tu es éligible pour récupèrer tes 3 Fun Points quotidiens!"
              ),
              actions: <Widget>[
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                    BlocProvider.of<NavigationBloc>(context).add(ChangeHomeTabNavigationEvent(homeIndex: 2));
                  },
                  child: Text("Récupèrer mes Fun Points"),
                )
              ],
            )
          );
        }
      },
      child: widget.child,
    );
  }
}