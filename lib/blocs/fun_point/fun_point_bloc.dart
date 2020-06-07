import 'package:bloc/bloc.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_event.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_state.dart';
import 'package:fun_prize/service/auth_service.dart';
import 'package:fun_prize/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FunPointBloc extends Bloc<FunPointEvent, FunPointState> {
  static String _kLastClaimedFunPointDateKey = "io.github.dogganidhal.fun_prize.last_claimed_fun_point_date";

  final AuthService authService = AuthService();
  final UserService userService = UserService();

  @override
  FunPointState get initialState => FunPointLoadingState();

  @override
  Stream<FunPointState> mapEventToState(FunPointEvent event) async* {

    final sharedPreferences = await SharedPreferences.getInstance();

     if (event is FunPointLoadEvent) {
       yield FunPointLoadingState();
       final user = await authService.loadCurrentUser();
       final lastClaimDateString = sharedPreferences.getString(_kLastClaimedFunPointDateKey);
       if (lastClaimDateString != null) {
         final lastClaimSession = DateTime.parse(lastClaimDateString);
         if (lastClaimSession.day < DateTime.now().day) {
           yield FunPointReadyState(
             canClaimFunPoint: true,
             user: user
           );
         } else {
           yield FunPointReadyState(
             canClaimFunPoint: false,
             user: user
           );
         }
       } else {
         yield FunPointReadyState(
           canClaimFunPoint: true,
           user: user
         );
       }
     }

     if (event is FunPointClaimEvent && state is FunPointReadyState) {
       await userService.addFunPoints((state as FunPointReadyState).user, 3);
       sharedPreferences.setString(_kLastClaimedFunPointDateKey, DateTime.now().toIso8601String());
       add(FunPointLoadEvent());
     }

     if (event is FunPointPlayEvent) {
       await userService.takeoutFunPoints((state as FunPointReadyState).user, 3);
       add(FunPointLoadEvent());
     }

  }
}