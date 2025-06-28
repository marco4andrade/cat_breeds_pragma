import '../../domain/entities/cat_breed.dart';
import '../../domain/repositories/cat_breed_repository.dart';

class SearchCatBreedUseCase {
  final CatBreedRepository repository;

  SearchCatBreedUseCase(this.repository);

  Future<List<CatBreed>> call(String query){
    return repository.searchCatBreedsRep(query);
  }
}