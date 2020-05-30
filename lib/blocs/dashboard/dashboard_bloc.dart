import 'package:bloc/bloc.dart';
import 'package:fun_prize/blocs/dashboard/dashboard_event.dart';
import 'package:fun_prize/blocs/dashboard/dashboard_state.dart';
import 'package:fun_prize/service/user_service.dart';


class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final UserService userService = UserService();

  @override
  DashboardState get initialState => DashboardState(
    participations: userService.userParticipations
  );

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
  }
}