import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/navigation/event/navigation_event.dart';
import 'package:fun_prize/blocs/navigation/state/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final GlobalKey<NavigatorState> navigatorState;

  NavigationBloc({@required this.navigatorState});

  @override
  NavigationState get initialState => NavigationState.initial();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {

    if (event is ChangeHomeTabNavigationEvent) {
      yield NavigationState(
        homeIndex: event.homeIndex
      );
    }

  }
}