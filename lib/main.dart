import 'package:flutter/material.dart';
import 'package:pragma_cats_breeds/domain/usecases/search_cat_breed.dart';
import 'package:pragma_cats_breeds/presentation/pages/splash_screen_cat_page.dart';
import 'data/datasources/cat_breed_remote_datasource.dart';
import 'data/repositories/cat_breed_repository_impl.dart';
import 'domain/usecases/get_cat_breeds.dart';
import 'presentation/pages/cat_breed_page.dart';

void main() {
  final remoteDatasource = CatBreedRemoteDatasource();
  final repository = CatBreedRepositoryImpl(remoteDatasource);
  final getCatBreeds = GetCatBreedsUseCase(repository);
  final searchCatBreeds = SearchCatBreedUseCase(repository);

  runApp(MyApp(getCatBreeds: getCatBreeds, searchCatBreeds: searchCatBreeds));
}

class MyApp extends StatelessWidget {
  final GetCatBreedsUseCase getCatBreeds;
  final SearchCatBreedUseCase searchCatBreeds;

  const MyApp({super.key, required this.getCatBreeds, required this.searchCatBreeds});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Breeds Pragma',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashCatPage(getCatBreeds: getCatBreeds, searchCatBreed: searchCatBreeds,),
    );
  }
}