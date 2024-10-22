part of 'select_filter_bloc.dart';

class SelectFilterState extends Equatable {
  final int currentPage;
  final String filterSelect;
  const SelectFilterState(
      {required this.currentPage, required this.filterSelect});

  @override
  List<Object?> get props => [currentPage, filterSelect];
}
