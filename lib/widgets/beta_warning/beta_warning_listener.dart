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
                  title: Center(
                    child: Text("Information importante"),
                  ),
                  content: Text(
                    "Merci d’avoir installé Prize&Fun !\n\n"
                    "Cette version est une démo de l’application qui sortira début 2021.\n\n"
                    "Nous nous excusons d’avance pour les éventuelles erreurs que vous rencontrerez.\n\n"
                    "Nous comptons sur votre compréhension et votre soutien pour nous améliorer 🙂\n\n"
                    "Pour toute réclamation, contactez : antonin@prize-and-fun.com\n\n"
                    "Amusez vous bien !"
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
