import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_bloc.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_event.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_state.dart';
import 'package:fun_prize/blocs/prize_details/prize_details_bloc.dart';
import 'package:fun_prize/blocs/prize_details/prize_details_event.dart';
import 'package:fun_prize/blocs/prize_details/prize_details_state.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/widgets/prizes/prize_rules.dart';
import 'package:fun_prize/widgets/prizes/rankings_card.dart';
import 'package:fun_prize/widgets/prizes/webview_scaffold.dart';


class PrizeDetails extends StatefulWidget {
  final Prize prize;

  PrizeDetails({Key key, @required this.prize}) : super(key: key);

  @override
  _PrizeDetailsState createState() => _PrizeDetailsState();
}

class _PrizeDetailsState extends State<PrizeDetails> {
  static const String _kPostScoreMethod = "io.github.dogganidhal.fun_prize/channel.post_score";

  PrizeDetailsBloc _bloc;
  final _methodChannel = MethodChannel("io.github.dogganidhal.fun_prize/channel");

  @override
  void initState() {
    super.initState();
    _bloc = PrizeDetailsBloc(
      prize: widget.prize
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
        builder: (context, state) => BlocListener<FunPointBloc, FunPointState>(
          listener: (context, state) {
            if (state is FunPointReadyState && state.prizeUnlocked) {
              Scaffold.of(context)
                .showSnackBar(SnackBar(
                  content: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Félicitations! Vous avez débloquer l'accès à ce concours, vous pouvez y jouer autant que vous voulez avant sa clôture"),
                  ),
                ));
            }
          },
          child: Column(
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
                          SizedBox(height: 48),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              if (widget.prize.merchantWebsite != null)
                                ...[
                                  Divider(height: 1),
                                  InkWell(
                                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => WebviewScaffold(
                                        url: widget.prize.merchantWebsite,
                                      )
                                    )),
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        children: <Widget>[
                                          Text("En savoir plus"),
                                          Expanded(child: Container()),
                                          Icon(
                                            Icons.chevron_right,
                                            color: Theme.of(context).primaryColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              Divider(height: 1),
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: <Widget>[
                                      Text("Classement général"),
                                      Expanded(child: Container()),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              if (widget.prize.prizeRules != null)
                                ...[
                                  Divider(height: 1),
                                  InkWell(
                                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PrizeRules(
                                        rules: widget.prize.prizeRules,
                                      )
                                    )),
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        children: <Widget>[
                                          Text("Règlement du concours"),
                                          Expanded(child: Container()),
                                          Icon(
                                            Icons.chevron_right,
                                            color: Theme.of(context).primaryColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1),
                                ]
                            ]
                          )
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
                    child: BlocBuilder<FunPointBloc, FunPointState>(
                      builder: (context, state) => MaterialButton(
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).dividerColor,
                        onPressed: _canPlay(state) ?
                          _play :
                          null,
                        child: Text(
                          _prizeUnlocked(state) ?
                            "🔓 Jouer" :
                            "🔒 Débloquer 💎x3"
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  void _play() {
    BlocProvider.of<FunPointBloc>(context).add(FunPointUnlockOrPlayPrizeEvent(
      prize: widget.prize,
      methodChannel: _methodChannel
    ));
  }

  bool _prizeUnlocked(FunPointState state) => state is FunPointReadyState &&
    state.user.prizeParticipationIds.contains(widget.prize.id);

  bool _canPlay(FunPointState state) => state is FunPointReadyState &&
    (state.user.funPoints >= 3 || _prizeUnlocked(state));
}