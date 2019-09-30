import 'package:flutter/material.dart';
import 'package:fun_prize/model/prize.dart';
import 'package:fun_prize/widgets/prizes/rankings_card.dart';


class PrizeDetails extends StatefulWidget {
  final Prize prize;

  const PrizeDetails({Key key, @required this.prize}) : super(key: key);

  @override
  _PrizeDetailsState createState() => _PrizeDetailsState();
}

class _PrizeDetailsState extends State<PrizeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      body: Column(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  elevation: 1,
                  expandedHeight: 192,
                  floating: false,
                  pinned: true,
                  brightness: Brightness.light,
                  iconTheme: IconThemeData(
                    color: Colors.amber
                  ),
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) => FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        opacity: constraints.biggest.height > (80 + MediaQuery.of(context).padding.top) ? 0 : 1,
                        duration: Duration(milliseconds: 200),
                        child: Text(
                          widget.prize.title,
                          style: TextStyle(
                            color: Colors.black
                          ),
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
                  child: Container(
                    color: Colors.white,
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
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Classement actuel",
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                        RankingsCard(rankings: widget.prize.rankings),
                      ],
                    ),
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
                  color: Colors.amber,
                  onPressed: () {},
                  child: Text("Jouer".toUpperCase()),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}