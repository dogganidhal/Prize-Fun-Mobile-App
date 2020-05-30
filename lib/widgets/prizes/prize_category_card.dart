import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/prize/prize_bloc.dart';
import 'package:fun_prize/blocs/prize/prize_event.dart';
import 'package:fun_prize/blocs/prize/prize_state.dart';
import 'package:fun_prize/model/prize_category.dart';
import 'package:transparent_image/transparent_image.dart';


class PrizeCategoryCard extends StatefulWidget {
  final PrizeBloc prizeBloc;
  final PrizeCategory category;

  const PrizeCategoryCard({Key key, this.prizeBloc, this.category}) : super(key: key);
  
  @override
  _PrizeCategoryCardState createState() => _PrizeCategoryCardState();
}

class _PrizeCategoryCardState extends State<PrizeCategoryCard> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PrizeBloc, PrizeState>(
      bloc: widget.prizeBloc,
      builder: (context, state) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: state.selectedCategoryIds.contains(widget.category.id) ?
            Theme.of(context).primaryColor :
            Theme.of(context).dividerColor,
            width: 0.4
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        color: state.selectedCategoryIds.contains(widget.category.id) ?
          Theme.of(context).primaryColor.withOpacity(0.75) :
          Theme.of(context).cardColor,
        child: GestureDetector(
          onTap: () {
            widget.prizeBloc.add(ToggleCategoryFilterEvent(category: widget.category));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: widget.category.photoUrl != null ?
                        FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: widget.category.photoUrl,
                          fit: BoxFit.cover,
                        ) :
                        Image.asset(
                          "assets/placeholder.jpeg",
                          fit: BoxFit.cover,
                        ),
                    ),
                    if (state.selectedCategoryIds.contains(widget.category.id))
                      Positioned.fill(
                        child: Container(
                          color: Theme.of(context).primaryColor.withAlpha(75),
                        )
                      )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(widget.category.title),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}