import 'package:provider/provider.dart';
import '../myapp/datasources/cat_breed_remote_datasource.dart';
import '../myapp/repositories/cat_breed_repository_impl.dart';
import '../myapp/usecases/get_cat_breeds.dart';
import '../myapp/usecases/search_cat_breed.dart';

/// Configura y registra todas las dependencias usando Provider
List<Provider> getProviders() {
  return [
    // Datasources
    Provider<CatBreedRemoteDatasource>(
      create: (_) => CatBreedRemoteDatasource(),
    ),
    
    // Repositories
    ProxyProvider<CatBreedRemoteDatasource, CatBreedRepositoryImpl>(
      update: (_, datasource, __) => CatBreedRepositoryImpl(datasource),
    ),
    
    // Use Cases
    ProxyProvider<CatBreedRepositoryImpl, GetCatBreedsUseCase>(
      update: (_, repository, __) => GetCatBreedsUseCase(repository),
    ),
    
    ProxyProvider<CatBreedRepositoryImpl, SearchCatBreedUseCase>(
      update: (_, repository, __) => SearchCatBreedUseCase(repository),
    ),
  ];
}