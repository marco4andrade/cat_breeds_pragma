import 'package:get_it/get_it.dart';
import 'package:pragma_cats_breeds/data/datasources/cat_breed_remote_datasource.dart';
import 'package:pragma_cats_breeds/data/repositories/cat_breed_repository_impl.dart';
import 'package:pragma_cats_breeds/domain/repositories/cat_breed_repository.dart';
import 'package:pragma_cats_breeds/domain/usecases/get_cat_breeds.dart';
import 'package:pragma_cats_breeds/domain/usecases/search_cat_breed.dart';

final sl = GetIt.instance;

void setupDependencies(){
  //Datasources
  sl.registerLazySingleton<CatBreedRemoteDatasource>(
    () => CatBreedRemoteDatasource()
  );

  //Repositories
  sl.registerLazySingleton<CatBreedRepository>(
    () => CatBreedRepositoryImpl(sl<CatBreedRemoteDatasource>())
  );

  //Use cases
  sl.registerLazySingleton<GetCatBreedsUseCase>(
    () => GetCatBreedsUseCase(sl<CatBreedRepository>())
  );
  sl.registerLazySingleton<SearchCatBreedUseCase>(
    () => SearchCatBreedUseCase(sl<CatBreedRepository>())
  );
}