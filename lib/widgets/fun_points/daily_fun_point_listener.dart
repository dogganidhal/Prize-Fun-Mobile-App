import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_bloc.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_event.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_state.dart';

class DailyFunPointListener extends StatefulWidget {
  final Widget child;

  const DailyFunPointListener({Key key, @required this.child}) : super(key: key);

  @override
  _DailyFunPointListenerState createState() => _DailyFunPointListenerState();
}

class _DailyFunPointListenerState extends State<DailyFunPointListener> {
  FunPointBloc _funPointBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _funPointBloc = BlocProvider.of<FunPointBloc>(context);
    _funPointBloc.add(FunPointLoadEvent());
  }

  @override
  void dispose() {
    _funPointBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FunPointBloc, FunPointState>(
      bloc: _funPointBloc,
      listener: (context, state) {
        if (state is FunPointReadyState && state.canClaimFunPoint) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)
              ),
              title: Text("Fun point quotidien"),
              content: Text(
                "Bravo! Tu es éligible pour récupèrer tes 3 Fun Point quotidien\n"
                  "Appuies sur le bouton ci-dessous pour le récupèrer"
              ),
              actions: <Widget>[
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    _funPointBloc.add(FunPointClaimEvent());
                    Navigator.of(context).pop();
                  },
                  child: Text("Récupèrer mes Fun Point"),
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