import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState.initial());

  void setSearchQuery(String val){
    emit(state.copyWith(searchQuery: val));
  }
}
