import 'package:bloc/bloc.dart';
import 'package:fun_prize/service/auth_service.dart';
import 'package:fun_prize/service/prize_service.dart';
import 'package:fun_prize/blocs/prize/prize_event.dart';
import 'package:fun_prize/blocs/prize/prize_state.dart';


class PrizeBloc extends Bloc<PrizeEvent, PrizeState> {
  PrizeService _prizeService = PrizeService();
  AuthService _authService = AuthService();

  @override
  PrizeState get initialState => PrizeState(
    prizes: _prizeService.prizes,
    selectedCategoryIds: [],
    userFuture: _authService.loadCurrentUser()
  );

  @override
  Stream<PrizeState> mapEventToState(PrizeEvent event) async* {

    if (event is ToggleCategoryFilterEvent) {
      final newCategoryList = List<String>.from(state.selectedCategoryIds);
      if (state.selectedCategoryIds.contains(event.category.id)) {
        newCategoryList.remove(event.category.id);
      } else {
        newCategoryList.add(event.category.id);
      }
      yield PrizeState(
        prizes: _prizeService.prizes
          .map((prizes) => prizes
          .where((prize) => prize.categoryId == null || newCategoryList.isEmpty || newCategoryList.contains(prize.categoryId))
          .toList()
        ),
        selectedCategoryIds: newCategoryList
      );
    }

    if (event is ClearCategoriesEvent) {
      yield PrizeState(
        prizes: _prizeService.prizes,
        selectedCategoryIds: []
      );
    }

  }

}