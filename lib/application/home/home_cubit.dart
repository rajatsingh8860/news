import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:news/data/home/model/home_model.dart';
import 'package:news/domain/home/home_repo.dart';
part 'home_state.dart';
part 'home_cubit.freezed.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeState.initial());

  getNewsFeedback({bool isPullToRefresh = false}) async {
    if (state.newsModel.length == 1 || state.categoryFilter) {
      emit(state.copyWith(newsModel: [], isLoading: true));
    } else {
      emit(state.copyWith(isLoading: true));
    }
    var result = await homeRepo.getNewsFeed(
        country: state.countryIso,
        isPullToRefresh: isPullToRefresh,
        sortUsing: state.sortParameter,
        sort: state.sort,
        page: state.pageNo,
        categoryName: state.categoryName);

    return result.fold((l) {}, (r) {
      if (r.toString() == '[]') {
        emit(state.copyWith(endOfList: true));
      }

      emit(state.copyWith(pageNo: state.pageNo + 1));

      final newsArticles = [state.newsModel, r].expand((x) => x).toList();

      emit(state.copyWith(newsModel: newsArticles, isLoading: false));
    });
  }

  void setSortParameter(String val) {
    emit(state.copyWith(sortParameter: val));
  }

  void emptyListValue() {
    emit(state.copyWith(newsModel: []));
  }

  void setCategoryFilter(bool val) {
    emit(state.copyWith(categoryFilter: val));
  }

  void resetPageNo() {
    emit(state.copyWith(pageNo: 1));
  }

  void setSort(bool val) {
    emit(state.copyWith(sort: val));
  }

  void setBottomSheetParameter(bool val) {
    emit(state.copyWith(showBottomSheet: val));
  }

  void setFilterBottomSheetParameter(bool val) {
    emit(state.copyWith(showFilterBottomSheet: val));
  }

  void setCountryName(String val) {
    emit(state.copyWith(countryName: val));
  }

  void setCountryIso(String val) {
    emit(state.copyWith(countryIso: val));
  }

  void setFilterParameter(String val) async {
    emit(state.copyWith(filterParameter: val));
  }

  void setParentBottomSheet(bool val) {
    emit(state.copyWith(showParentBottomSheet: val));
  }

  void setCategorySelectionBottomSheet(bool val) {
    emit(state.copyWith(categorySelectionBottomSheet: val));
  }

  void setCategoryName(String val) {
    emit(state.copyWith(categoryName: val));
  }
}
