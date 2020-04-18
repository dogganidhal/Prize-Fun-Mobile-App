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
import 'package:fun_prize/utils/constants.dart';
import 'package:fun_prize/widgets/auth/auth.dart';
import 'package:fun_prize/widgets/prizes/category_select.dart';
import 'package:fun_prize/widgets/prizes/prize_card.dart';
import 'package:fun_prize/widgets/prizes/prize_details.dart';


class Prizes extends StatelessWidget {
  final PrizesBloc _bloc = PrizesBloc();

  Prizes({Key key}) : super(key: key) {
    _bloc.add(LoadPrizesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Image.asset(Constants.logoAsset, height: 48,),
        ),
        centerTitle: true,
        actions: <Widget>[
          ButtonTheme(
            focusColor: Colors.black54,
            child: IconButton(
              icon: Icon(Icons.category),
              onPressed: () =>  Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CategorySelect()
              ))
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1)
        ),
      ),
      body: BlocBuilder<PrizesBloc, PrizesState>(
        bloc: _bloc,
        builder: (context, state) {
          return StreamBuilder<List<Prize>>(
            stream: state.prizes,
            builder: (context, snapshot) {
              return Stack(
                children: <Widget>[
                if (snapshot.hasData)
                  ListView.separated(
                    padding: EdgeInsets.all(8),
                    itemBuilder: (context, index) => PrizeCard(
                      prize: snapshot.data[index],
                      onPlayPressed: () => _launchPrizeDetails(context, snapshot.data[index]),
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemCount: snapshot.data.length
                  ),
                if (snapshot.connectionState == ConnectionState.waiting)
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Center(
                        child: Platform.isIOS ?
                        CupertinoActivityIndicator() :
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)
                        )
                      ),
                    )
                  )
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