import 'package:flutter/material.dart';
import 'package:fun_prize/widgets/dashboard/dashboard.dart';
import 'package:fun_prize/widgets/fun_points/fun_points.dart';
import 'package:fun_prize/widgets/prizes/prizes.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: <Widget>[
          Prizes(),
          Dashboard(),
          FunPoints()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _index,
        onTap: (index) => setState(() => _index = index),
        selectedItemColor: Theme.of(context).primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/gift.png",
              height: 24,
              colorBlendMode: BlendMode.srcIn,
              color: _index == 0 ?
                Theme.of(context).primaryColor :
                Theme.of(context).unselectedWidgetColor,
            ),
            title: Text('Concours')
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/statistics.png",
              height: 24,
              colorBlendMode: BlendMode.srcIn,
              color: _index == 1 ?
              Theme.of(context).primaryColor :
              Theme.of(context).unselectedWidgetColor,
            ),
            title: Text('Tableau de bord')
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/fun-point.png",
              height: 24,
              colorBlendMode: BlendMode.srcIn,
              color: _index == 2 ?
                Theme.of(context).primaryColor :
                Theme.of(context).unselectedWidgetColor,
            ),
            title: Text('Fun points')
          )
        ],
      ),
    );
  }
}