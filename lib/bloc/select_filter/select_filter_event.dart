part of 'select_filter_bloc.dart';

sealed class SelectFilterEvent extends Equatable {}

class CallSelect extends SelectFilterEvent {
  final int currentPage;
  final String filterSelect;

  CallSelect({required this.currentPage, required this.filterSelect});
  @override
  List<Object?> get props => [currentPage, filterSelect];
}
