part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {

  const factory HomeState({
    required List<NewsModel> newsModel,
    @Default('Newest') sortParameter,
    @Default(true) bool isLoading,
    @Default(false) bool showBottomSheet,
    @Default("India") String countryName,
    @Default("in") String countryIso,
    @Default(false) bool sort,
    @Default(false) bool showFilterBottomSheet,
    @Default('') String filterParameter,
    @Default(false) bool showParentBottomSheet,
    @Default(false) bool categorySelectionBottomSheet,
    @Default('') String categoryName,
    @Default(true) connected,
    @Default(1) int pageNo,
    @Default(false) bool endOfList,
    @Default(false) bool categoryFilter
  })  = _HomeState;

  factory HomeState.initial() => HomeState(
    newsModel: [NewsModel()],
    sortParameter: "Newest",
    isLoading: true,
    categoryFilter: false,
    showBottomSheet: false,
    countryName: "India",
    countryIso: "in",
    sort: false,
    showFilterBottomSheet: false,
    filterParameter: '',
    showParentBottomSheet: false,
    categorySelectionBottomSheet: false,
    categoryName: '',
    connected: true,
    pageNo: 1,
    endOfList: false
    );
}
