import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/prizes/prizes_bloc.dart';
import 'package:fun_prize/blocs/prizes/prizes_event.dart';
import 'package:fun_prize/blocs/prizes/prizes_state.dart';
import 'package:fun_prize/model/prize_category.dart';


class PrizeCategoryCard extends StatefulWidget {
  final PrizesBloc prizesBloc;
  final PrizeCategory category;

  const PrizeCategoryCard({Key key, this.prizesBloc, this.category}) : super(key: key);
  
  @override
  _PrizeCategoryCardState createState() => _PrizeCategoryCardState();
}

class _PrizeCategoryCardState extends State<PrizeCategoryCard> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PrizesBloc, PrizesState>(
      bloc: widget.prizesBloc,
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
            widget.prizesBloc.add(ToggleCategoryFilterEvent(category: widget.category));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: widget.category.photoUrl != null ?
                        CachedNetworkImage(
                          imageUrl: widget.category.photoUrl,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                            LinearProgressIndicator(
                              value: downloadProgress.progress,
                            ),
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