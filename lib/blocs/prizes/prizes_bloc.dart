import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fun_prize/blocs/prizes/prizes_event.dart';
import 'package:fun_prize/blocs/prizes/prizes_state.dart';
import 'package:fun_prize/service/prizes_service.dart';


class PrizesBloc extends Bloc<PrizesEvent, PrizesState> {
  PrizesService _prizesService = PrizesService();

  @override
  PrizesState get initialState => PrizesState(
    prizes: _prizesService.prizes,
    selectedCategoryIds: []
  );

  @override
  Stream<PrizesState> mapEventToState(PrizesEvent event) async* {

    if (event is ToggleCategoryFilterEvent) {
      final newCategoryList = List<String>.from(state.selectedCategoryIds);
      if (state.selectedCategoryIds.contains(event.category.id)) {
        newCategoryList.remove(event.category.id);
      } else {
        newCategoryList.add(event.category.id);
      }
      yield PrizesState(
        prizes: _prizesService.prizes
          .map((prizes) => prizes
          .where((prize) => newCategoryList.isEmpty || newCategoryList.contains(prize.categoryId))
          .toList()
        ),
        selectedCategoryIds: newCategoryList
      );
    }

    if (event is ClearCategoriesEvent) {
      yield PrizesState(
        prizes: _prizesService.prizes,
        selectedCategoryIds: []
      );
    }

  }

}