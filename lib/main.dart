import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_cats_breeds/di/injection.dart';
import 'package:pragma_cats_breeds/domain/usecases/search_cat_breed.dart';
import 'package:pragma_cats_breeds/presentation/bloc/cat_breeds_bloc.dart';
import 'package:pragma_cats_breeds/presentation/pages/splash_screen_cat_page.dart';
import 'data/datasources/cat_breed_remote_datasource.dart';
import 'data/repositories/cat_breed_repository_impl.dart';
import 'domain/usecases/get_cat_breeds.dart';
import 'presentation/pages/cat_breed_page.dart';

void main() {
  setupDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CatBreedsBloc(
            getCatBreedsUseCase: sl(),
            searchCatBreedUseCase: sl(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Cat Breeds Pragma',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: SplashCatPage(),
      ),
    );
  }
}
