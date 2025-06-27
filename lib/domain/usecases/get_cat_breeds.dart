import '../entities/cat_breed.dart';
import '../repositories/cat_breed_repository.dart';

class GetCatBreedsUseCase {
  final CatBreedRepository repository;

  GetCatBreedsUseCase(this.repository);

  Future<List<CatBreed>> call() => repository.getCatBreedsRep();
  
}