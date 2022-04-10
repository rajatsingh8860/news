part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {

  const factory SearchState({
    @Default('') searchQuery,
  })  = _SearchState;

  factory SearchState.initial() => const SearchState(
    searchQuery: ''
  );
}
