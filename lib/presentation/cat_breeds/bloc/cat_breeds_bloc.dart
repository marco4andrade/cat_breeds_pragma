import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_cats_breeds/domain/usecases/get_cat_breeds.dart';
import 'package:pragma_cats_breeds/domain/usecases/search_cat_breed.dart';
import 'package:pragma_cats_breeds/presentation/cat_breeds/bloc/cat_breeds_event.dart';
import 'package:pragma_cats_breeds/presentation/cat_breeds/bloc/cat_breeds_state.dart';

class CatBreedsBloc extends Bloc<CatBreedsEvent, CatBreedsState> {
  final GetCatBreedsUseCase getCatBreedsUseCase;
  final SearchCatBreedUseCase searchCatBreedUseCase;

  CatBreedsBloc({
    required this.getCatBreedsUseCase,
    required this.searchCatBreedUseCase,
  }) : super(CatBreedsInitial()) {
    on<LoadCatBreeds>(_onLoadCatBreeds);
    on<SearchCatBreeds>(_onSearchCatBreeds);
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onLoadCatBreeds(
    LoadCatBreeds event,
    Emitter<CatBreedsState> emit,
  ) async {
    emit(CatBreedsLoading());
    try {
      final breeds = await getCatBreedsUseCase();
      emit(CatBreedsLoaded(breeds));
    } catch (e) {
      emit(CatBreedsError('Service error'));
    }
  }

  Future<void> _onSearchCatBreeds(
    SearchCatBreeds event,
    Emitter<CatBreedsState> emit,
  ) async {
    emit(CatBreedsLoading());
    try {
      final results = await searchCatBreedUseCase(event.query);
      emit(CatBreedsLoaded(results));
    } catch (e) {
      emit(CatBreedsError('There are no matches'));
    }
  }

  Future<void> _onClearSearch(
    ClearSearch event,
    Emitter<CatBreedsState> emit,
  ) async {
    emit(CatBreedsLoading());
    try {
      final breeds = await getCatBreedsUseCase();
      emit(CatBreedsLoaded(breeds));
    } catch (e) {
      emit(CatBreedsError('Error loading cat breeds'));
    }
  }
}
