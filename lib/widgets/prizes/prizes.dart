import 'dart:io' show Platform;
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/prizes/prizes_bloc.dart';
import 'package:fun_prize/blocs/prizes/prizes_event.dart';
import 'package:fun_prize/blocs/prizes/prizes_state.dart';
import 'package:fun_prize/utils/contants.dart';
import 'package:fun_prize/widgets/prizes/prize_card.dart';


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
          padding: EdgeInsets.only(bottom: 8),
          child: Image.asset(Constants.logoAsset),
        ),
        centerTitle: true,
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
                    onPlayPressed: () {
                      debugPrint("Want to play prize at index $index ?");
                    },
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
                      CircularProgressIndicator()
                    ),
                  )
                ),
            ],
          );
        },
      )
    );
  }
}