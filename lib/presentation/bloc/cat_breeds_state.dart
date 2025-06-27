import 'package:equatable/equatable.dart';
import 'package:pragma_cats_breeds/domain/entities/cat_breed.dart';

abstract class CatBreedsState extends Equatable {
  const CatBreedsState();

  @override
  List<Object?> get props => [];
}

class CatBreedsInitial extends CatBreedsState {}

class CatBreedsLoading extends CatBreedsState {}

class CatBreedsLoaded extends CatBreedsState {
  final List<CatBreed> breeds;
  const CatBreedsLoaded(this.breeds);

  @override
  List<Object?> get props => [breeds];
}

class CatBreedsError extends CatBreedsState {
  final String message;
  const CatBreedsError(this.message);

  @override
  List<Object?> get props => [message];
}