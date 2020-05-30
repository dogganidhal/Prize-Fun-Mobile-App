import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:fun_prize/blocs/prize/prize_bloc.dart';
import 'package:fun_prize/blocs/prize/prize_event.dart';
import 'package:fun_prize/model/prize_category.dart';
import 'package:fun_prize/service/prizes_service.dart';
import 'package:fun_prize/widgets/prizes/prize_category_card.dart';


class CategorySelect extends StatefulWidget {
  final PrizeBloc prizeBloc;

  const CategorySelect({Key key, this.prizeBloc}) : super(key: key);

  @override
  _CategorySelectState createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  final PrizesService prizesService = PrizesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text("Catégories"),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1)
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: () => widget.prizeBloc.add(ClearCategoriesEvent())
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => Navigator.of(context).pop()
          ),
        ],
      ),
      body: FutureBuilder<List<PrizeCategory>>(
        future: prizesService.categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return _categoriesGrid(snapshot.data);
          }
          return Container();
        },
      ),
    );
  }

  Widget _categoriesGrid(List<PrizeCategory> categories) {
    final groupedCategories = groupBy(categories, (PrizeCategory category) => category.type);
    return CustomScrollView(
      slivers: <Widget>[
        ...groupedCategories.keys
          .map((type) => SliverStickyHeader(
            header: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  color: Theme.of(context).backgroundColor,
                  child: Text(
                    stringForPrizeCategoryType(type),
                    style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(
                        color: Theme.of(context).primaryColor
                      ),
                  ),
                ),
                Divider(height: 1)
              ],
            ),
            sliver: SliverStaggeredGrid.countBuilder(
              crossAxisCount: 2,
              itemCount: groupedCategories[type].length,
              itemBuilder: (context, index) => SizedBox(
                height: 200,
                child: PrizeCategoryCard(
                  prizeBloc: widget.prizeBloc,
                  category: groupedCategories[type][index]
                )
              ),
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ))
          .toList()
      ],
    );
  }
}