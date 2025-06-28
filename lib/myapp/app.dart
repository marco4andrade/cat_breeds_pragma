import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../di/injection.dart';
import '../presentation/pages/splash_screen_cat_page.dart';
import 'usecases/get_cat_breeds.dart';
import 'usecases/search_cat_breed.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: getProviders(),
      child: MaterialApp(
        title: 'Cat Breeds Pragma',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const _HomePage(),
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    // Ejemplo de cómo acceder a los casos de uso usando Provider
    final getCatBreeds = Provider.of<GetCatBreedsUseCase>(context, listen: false);
    final searchCatBreeds = Provider.of<SearchCatBreedUseCase>(context, listen: false);
    
    return SplashCatPage(
      getCatBreeds: getCatBreeds,
      searchCatBreed: searchCatBreeds,
    );
  }
}