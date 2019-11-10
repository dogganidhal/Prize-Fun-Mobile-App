import 'package:flutter/material.dart';
// import 'package:fun_prize/model/game_engine.dart';
import 'package:fun_prize/unity/demo.dart';
// import 'package:fun_prize/widgets/game/prize_fun_game.dart';


void main() async {
  // final engine = GameEngine();
  // final prizeAndFunGame = PrizeFunGame(engine: engine);

  runApp(UnityDemo());
  // runApp(prizeAndFunGame.widget);
//  final user = await AuthService().currentUser();
//  runApp(App(isAuthenticated: user != null));
}