import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_filter_event.dart';
part 'select_filter_state.dart';

class SelectFilterBloc extends Bloc<SelectFilterEvent, SelectFilterState> {
  SelectFilterBloc()
      : super(const SelectFilterState(currentPage: 0, filterSelect: "")) {
    on<CallSelect>((event, emit) {
      emit(SelectFilterState(
        currentPage: event.currentPage,
        filterSelect: event.filterSelect,
      ));
    });
  }
}
