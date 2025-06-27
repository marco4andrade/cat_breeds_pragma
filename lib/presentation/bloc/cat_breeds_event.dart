
import 'package:equatable/equatable.dart';

abstract class CatBreedsEvent extends Equatable{
  const CatBreedsEvent();

  @override
  List<Object?> get props => [];
}

class LoadCatBreeds extends CatBreedsEvent {}

class SearchCatBreeds extends CatBreedsEvent {
  final String query;
  const SearchCatBreeds(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearSearch extends CatBreedsEvent {}