import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_bloc.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_event.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_state.dart';

class FunPoints extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FunPointsState();
}

class _FunPointsState extends State<FunPoints> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: BlocBuilder<FunPointBloc, FunPointState>(
            builder: (context, state) => Column(
              children: <Widget>[
                _header(state),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.9,
                  children: [
                    _buyCard,
                    _dailyFunPointCard(state),
                    _referCard,
                    _adCard,
                  ]
                    .map((widget) => Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 0.4
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: widget,
                  ))
                    .toList(),
                  crossAxisCount: 2
                ),
              ],
            )
          ),
        ),
      )
    );
  }

  Widget _header(FunPointState state) {
    return Padding(
      padding: EdgeInsets.only(top: 64),
      child: Column(
        children: <Widget>[
          Image.asset('assets/fun-point-diamond.png'),
          Text(
            "${state is FunPointReadyState ? state.user.funPoints : "-"} Fun Points",
            style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500
              ),
          ),
          SizedBox(height: 16),
          Text(
            'Tu en veux plus ?',
            style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontWeight: FontWeight.w500
              ),
          )
        ],
      ),
    );
  }

  Widget get _buyCard => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 16),
        child: Image.asset(
          'assets/buy-fun-point.png',
          height: 48,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          'Acquières en marché',
          style: Theme.of(context)
            .textTheme
            .subtitle1,
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: ButtonTheme(
          minWidth: double.infinity,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
            ),
            color: Theme.of(context).dividerColor,
            textColor: Theme.of(context).disabledColor,
            onPressed: _openUnavailableFeatureDialog,
            child: Text('Acheter'),
          ),
        ),
      )
    ],
  );

  Widget _dailyFunPointCard(FunPointState state) => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 16),
        child: Image.asset(
          'assets/daily-fun-point.png',
          height: 48,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          'Obtiens ton Fun Point quotidien',
          style: Theme.of(context)
            .textTheme
            .subtitle1,
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: ButtonTheme(
          minWidth: double.infinity,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
            ),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).dividerColor,
            onPressed: state is FunPointReadyState && state.canClaimFunPoint ?
              () {
                BlocProvider.of<FunPointBloc>(context).add(FunPointClaimEvent());
              } :
              null,
            child: Text(
              state is FunPointReadyState && state.canClaimFunPoint ?
                'Ouvrir' :
                'Déjà récupéré'
            ),
          ),
        ),
      )
    ],
  );

  Widget get _adCard => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 16),
        child: Image.asset(
          'assets/ad.png',
          height: 48,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          'Visionne une publicité récompensée',
          style: Theme.of(context)
            .textTheme
            .subtitle1,
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: ButtonTheme(
          minWidth: double.infinity,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
            ),
            color: Theme.of(context).dividerColor,
            textColor: Theme.of(context).disabledColor,
            onPressed: _openUnavailableFeatureDialog,
            child: Text('Visionner'),
          ),
        ),
      )
    ],
  );

  Widget get _referCard => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 16),
        child: Image.asset(
          'assets/refer.png',
          height: 48,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          'Invite des amis à jouer',
          style: Theme.of(context)
            .textTheme
            .subtitle1,
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: ButtonTheme(
          minWidth: double.infinity,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
            ),
            color: Theme.of(context).dividerColor,
            textColor: Theme.of(context).disabledColor,
            onPressed: _openUnavailableFeatureDialog,
            child: Text('Parrainer'),
          ),
        ),
      )
    ],
  );

  void _openUnavailableFeatureDialog() {
    showDialog(
      context: context,
      builder: (context,) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        title: Text("Fonctionnalité indisponible"),
        content: Text(
          "Cette fontionnalité n'est pas encore disponible dans cette version bêta"
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      )
    );
  }
}