import 'dart:io' show Platform;
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_event.dart';
import 'package:fun_prize/blocs/prizes/prizes_bloc.dart';
import 'package:fun_prize/blocs/prizes/prizes_event.dart';
import 'package:fun_prize/blocs/prizes/prizes_state.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/utils/contants.dart';
import 'package:fun_prize/widgets/auth/auth.dart';
import 'package:fun_prize/widgets/prizes/prize_card.dart';
import 'package:fun_prize/widgets/prizes/prize_details.dart';


class Prizes extends StatelessWidget {
  final PrizesBloc _bloc = PrizesBloc();

  Prizes({Key key}) : super(key: key) {
    _bloc.dispatch(LoadPrizesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Image.asset(Constants.logoAsset),
        ),
        centerTitle: true,
        actions: <Widget>[
          ButtonTheme(
            focusColor: Colors.black54,
            child: PopupMenuButton(
              onSelected: (index) => _onPopupItemPressed(context, index),
              icon: Icon(Icons.more_vert, color: Colors.black87),
              tooltip: "Afficher le menu",
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Rafraîchir"),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Se déconnecter"),
                )
              ],
            ),
          )
        ],
      ),
      body: BlocBuilder<PrizesBloc, PrizesState>(
        bloc: _bloc,
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Positioned.fill(
                child: ListView.separated(
                  padding: EdgeInsets.all(8),
                  itemBuilder: (context, index) => PrizeCard(
                    prize: state.prizes[index],
                    onPlayPressed: () => _launchPrizeDetails(context, state.prizes[index]),
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemCount: state.prizes.length
                )
              ),
              if (state.isLoading)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Center(
                      child: Platform.isIOS ?
                        CupertinoActivityIndicator() :
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Constants.primaryColor)
                        )
                    ),
                  )
                ),
            ],
          );
        },
      )
    );
  }

  void _launchPrizeDetails(BuildContext context, Prize prize) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Theme(
          data: Theme.of(context),
          child: PrizeDetails(
            prize: prize,
          ),
        )
      ));
  }

  void _onPopupItemPressed(BuildContext context, int index) {
    switch(index) {
      case 0:
        _bloc.dispatch(LoadPrizesEvent());
        break;
      case 1:
        BlocProvider.of<AuthBloc>(context).dispatch(LogoutEvent());
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Auth(
            postAuthWidgetBuilder: (context) => Prizes(),
          )
        ));
        break;
    }
  }
}