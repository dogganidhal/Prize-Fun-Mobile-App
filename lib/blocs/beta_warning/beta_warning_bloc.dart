import 'package:bloc/bloc.dart';
import 'package:fun_prize/blocs/beta_warning/beta_warning_event.dart';
import 'package:fun_prize/blocs/beta_warning/beta_warning_state.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BetaWarningBloc extends Bloc<BetaWarningEvent, BetaWarningState> {
  static String _kFirstOpenKey = "io.github.dogganidhal.fun_prize.first_open";

  @override
  BetaWarningState get initialState => BetaWarningLoadingState();

  @override
  Stream<BetaWarningState> mapEventToState(BetaWarningEvent event) async* {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (event is LoadBetaWarningEvent) {
      final isFirstOpen = !sharedPreferences.containsKey(_kFirstOpenKey);
      await sharedPreferences.setString(_kFirstOpenKey, "NO");
      yield BetaWarningReadyState(isFirstOpen);
    }

  }
}
