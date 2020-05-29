import 'package:flutter/material.dart';
import 'package:fun_prize/widgets/dashboard/dashboard.dart';
import 'package:fun_prize/widgets/prizes/prizes.dart';
import 'package:fun_prize/widgets/profile/profile.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _index = 0;

  final Widget _prizes = Prizes();
  final Widget _profile = Profile();
  final Widget _dashboard = Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: <Widget>[
          _prizes,
          _dashboard,
          _profile
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
            icon: Icon(Icons.person_outline),
            title: Text('Tableau de bord')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('Profil')
          )
        ],
      ),
    );
  }
}