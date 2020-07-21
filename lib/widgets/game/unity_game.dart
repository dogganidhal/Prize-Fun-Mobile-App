import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unity/flutter_unity.dart';
import 'package:fun_prize/blocs/game/game_bloc.dart';
import 'package:fun_prize/blocs/game/game_event.dart';
import 'package:fun_prize/blocs/navigation/navigation_bloc.dart';
import 'package:fun_prize/model/prize.dart';


class UnityGame extends StatefulWidget {
  final Prize prize;

  const UnityGame({Key key, this.prize}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UnityGameState();
}

class _UnityGameState extends State<UnityGame> {
  GameBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = GameBloc(
      prize: widget.prize,
      navigationBloc: BlocProvider.of<NavigationBloc>(context)
    );
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    _bloc.close();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UnityView(
        onCreated: _onCreated,
        onMessage: _onMessage,
        onReattached: _onReattached,
      ),
    );
  }

  void _onCreated(UnityViewController controller) {
    _bloc.add(UnityGameCreatedEvent(
      controller: controller,
      prize: widget.prize
    ));
  }

  void _onMessage(UnityViewController controller, String message) {
    _bloc.add(UnityMessageReceivedEvent(message: message));
  }

  void _onReattached(UnityViewController controller) {
    debugPrint('onReattached');
  }
}