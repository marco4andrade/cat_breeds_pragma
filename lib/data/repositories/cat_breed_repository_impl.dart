import '../../domain/entities/cat_breed.dart';
import '../../domain/repositories/cat_breed_repository.dart';
import '../datasources/cat_breed_remote_datasource.dart';

class CatBreedRepositoryImpl implements CatBreedRepository {
  final CatBreedRemoteDatasource remoteDatasource;

  CatBreedRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<CatBreed>> getCatBreedsRep() async {
    return await remoteDatasource.getCatBreeds();
  }

  @override
  Future<List<CatBreed>> searchCatBreedsRep(String query) async {
    return await remoteDatasource.searchCatBreeds(query);
  }
}