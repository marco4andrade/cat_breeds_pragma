import '../entities/cat_breed.dart';

abstract class CatBreedRepository {
  Future<List<CatBreed>> getCatBreedsRep();
  Future<List<CatBreed>> searchCatBreedsRep(String query);
}