import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/beta_warning/beta_warning_bloc.dart';
import 'package:fun_prize/blocs/beta_warning/beta_warning_event.dart';
import 'package:fun_prize/blocs/beta_warning/beta_warning_state.dart';


class BetaWarningListener extends StatefulWidget {
  final Widget child;

  const BetaWarningListener({Key key, this.child}) : super(key: key);

  @override
  _BetaWarningListenerState createState() => _BetaWarningListenerState();
}

class _BetaWarningListenerState extends State<BetaWarningListener> {
  final BetaWarningBloc _betaWarningBloc = BetaWarningBloc();

  @override
  void initState() {
    super.initState();
    _betaWarningBloc.add(LoadBetaWarningEvent());
  }

  @override
  void dispose() {
    _betaWarningBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BetaWarningBloc, BetaWarningState>(
      bloc: _betaWarningBloc,
        listener: (context, state) {
          if (state is BetaWarningReadyState && state.firstOpen) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)
                  ),
                  title: Text("Infos importantes!"),
                  content: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                          "Nunc ex urna, elementum eu mollis quis, auctor sed "
                          "nunc. Vivamus tempus placerat risus eget pharetra. "
                          "Suspendisse rutrum placerat sapien, sed scelerisque "
                          "risus ullamcorper eu. Donec a enim turpis. "
                          "Nam pulvinar consectetur bibendum. Nam tristique "
                          "porta dolor in volutpat. Praesent vitae vulputate "
                          "ligula, quis volutpat lorem."
                  ),
                  actions: <Widget>[
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () => Navigator.pop(context),
                      child: Text("Je comprends"),
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
