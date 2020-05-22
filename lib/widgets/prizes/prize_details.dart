import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/prize_details/prize_details_bloc.dart';
import 'package:fun_prize/blocs/prize_details/prize_details_event.dart';
import 'package:fun_prize/blocs/prize_details/prize_details_state.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/service/auth_service.dart';
import 'package:fun_prize/service/prizes_service.dart';
import 'package:fun_prize/widgets/prizes/rankings_card.dart';
import 'package:fluttertoast/fluttertoast.dart';


class PrizeDetails extends StatefulWidget {
  final Prize prize;

  PrizeDetails({Key key, @required this.prize}) : super(key: key);

  @override
  _PrizeDetailsState createState() => _PrizeDetailsState();
}

class _PrizeDetailsState extends State<PrizeDetails> {
  static const String _kPostScoreMethod = "io.github.dogganidhal.fun_prize/channel.post_score";
  static const String _kStartGameMethod = "io.github.dogganidhal.fun_prize/channel.start_game";

  PrizeDetailsBloc _bloc;
  final _methodChannel = MethodChannel("io.github.dogganidhal.fun_prize/channel");

  @override
  void initState() {
    super.initState();
    _bloc = PrizeDetailsBloc(
      prize: widget.prize,
      authService: AuthService(),
      prizesService: PrizesService()
    );
    _methodChannel.setMethodCallHandler((methodCall) async {
      switch(methodCall.method) {
        case _kPostScoreMethod:
          final score = methodCall.arguments as int;
          if (score != null) {
            _bloc.add(PostScoreEvent(score));
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      body: BlocBuilder<PrizeDetailsBloc, PrizeDetailsState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state.didPostScore) {
            Fluttertoast.showToast(
              msg: "Score soumis avec succès",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0,
            );
          }
          return Column(
            children: <Widget>[
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      elevation: 0,
                      expandedHeight: 192,
                      pinned: true,
                      backgroundColor: Theme.of(context).backgroundColor,
                      iconTheme: IconThemeData(
                        color: Theme.of(context).primaryColor
                      ),
                      bottom: PreferredSize(
                        child: Divider(height: 1),
                        preferredSize: Size.fromHeight(1)
                      ),
                      flexibleSpace: LayoutBuilder(
                        builder: (context, constraints) => FlexibleSpaceBar(
                          centerTitle: true,
                          title: AnimatedOpacity(
                            opacity: constraints.biggest.height > (80 + MediaQuery.of(context).padding.top) ? 0 : 1,
                            duration: Duration(milliseconds: 200),
                            child: Text(
                              widget.prize.title,
                              style: TextStyle(color: Theme.of(context).textTheme.body1.color)
                            ),
                          ),
                          background: Image.network(
                            widget.prize.imageUrl,
                            fit: BoxFit.cover
                          ),
                        ),
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    widget.prize.subTitle,
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(widget.prize.description),
                                ),
                                RankingsCard(
                                  prize: widget.prize,
                                  rankings: state.rankings,
                                  userFuture: state.userFuture,
                                ),
                              ],
                            ),
                          ),
                          Container(height: 360)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SafeArea(
                  top: false,
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 48,
                    child: MaterialButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        _methodChannel.invokeMethod(_kStartGameMethod);
                      },
                      child: Text("Jouer"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}