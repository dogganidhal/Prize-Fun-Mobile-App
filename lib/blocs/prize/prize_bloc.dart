import 'package:bloc/bloc.dart';
import 'package:fun_prize/service/prizes_service.dart';
import 'package:fun_prize/blocs/prize/prize_event.dart';
import 'package:fun_prize/blocs/prize/prize_state.dart';


class PrizeBloc extends Bloc<PrizeEvent, PrizeState> {
  PrizesService _prizesService = PrizesService();

  @override
  PrizeState get initialState => PrizeState(
    prizes: _prizesService.prizes,
    selectedCategoryIds: []
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
        prizes: _prizesService.prizes
          .map((prizes) => prizes
          .where((prize) => prize.categoryId == null || newCategoryList.isEmpty || newCategoryList.contains(prize.categoryId))
          .toList()
        ),
        selectedCategoryIds: newCategoryList
      );
    }

    if (event is ClearCategoriesEvent) {
      yield PrizeState(
        prizes: _prizesService.prizes,
        selectedCategoryIds: []
      );
    }

  }

}