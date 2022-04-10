

import 'package:dartz/dartz.dart';
import 'package:news/data/home/model/home_model.dart';

abstract class HomeRepo{
  Future<Either<String , List<NewsModel>>> getNewsFeed({String country,bool isPullToRefresh,String sortUsing,bool sort,String categoryName,int page});
}