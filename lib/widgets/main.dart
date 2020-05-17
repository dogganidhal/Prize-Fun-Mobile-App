import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: <Widget>[
          _prizes,
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
            icon: Icon(Icons.card_giftcard),
            title: Text('Concours')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profil')
          )
        ],
      ),
    );
  }
}