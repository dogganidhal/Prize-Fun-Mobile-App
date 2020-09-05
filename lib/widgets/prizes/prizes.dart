import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/prize/prize_bloc.dart';
import 'package:fun_prize/blocs/prize/prize_state.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/utils/constants.dart';
import 'package:fun_prize/widgets/prizes/category_select.dart';
import 'package:fun_prize/widgets/prizes/prize_card.dart';
import 'package:fun_prize/widgets/prizes/prize_details.dart';


class Prizes extends StatefulWidget {
  @override
  _PrizesState createState() => _PrizesState();
}

class _PrizesState extends State<Prizes> {
  final PrizeBloc _bloc = PrizeBloc();

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
          child: Image.asset(Constants.logoAsset, height: 48),
        ),
        centerTitle: true,
        actions: <Widget>[
          ButtonTheme(
            focusColor: Colors.black54,
            child: IconButton(
              icon: Image.asset(
                "assets/category-icon.png",
                height: 24,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () =>  Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CategorySelect(prizeBloc: _bloc)
              ))
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1)
        ),
      ),
      body: BlocBuilder<PrizeBloc, PrizeState>(
        bloc: _bloc,
        builder: (context, state) {
          return StreamBuilder<List<Prize>>(
            stream: state.prizes,
            builder: (context, snapshot) {
              return Stack(
                children: <Widget>[
                  if (snapshot.connectionState == ConnectionState.waiting)
                    Positioned(
                      top: 0, left: 0, right: 0, height: 4,
                      child: LinearProgressIndicator()
                    ),
                  if (snapshot.hasData)
                    ListView.separated(
                      padding: EdgeInsets.all(8),
                      itemBuilder: (context, index) => index == 0 ?
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Theme.of(context).primaryColor
                          )
                        ),
                        child: Text("""Tous les concours affichés actuellement sont factices et ont pour but de présenter le concept de l’application.
Les vrais concours seront lancés à partir de Novembre.
Merci de votre compréhension""",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor
                          ),
                        ),
                      ) :
                      PrizeCard(
                        prize: snapshot.data[index - 1],
                        onPlayPressed: () => _launchPrizeDetails(context, snapshot.data[index - 1]),
                        userFuture: state.userFuture,
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount: snapshot.data.length
                    ),
                ],
              );
            }
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
}