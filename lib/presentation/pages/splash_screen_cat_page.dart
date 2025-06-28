import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pragma_cats_breeds/domain/usecases/get_cat_breeds.dart';
import 'package:pragma_cats_breeds/domain/usecases/search_cat_breed.dart';
import 'package:pragma_cats_breeds/presentation/pages/cat_breed_page.dart';

class SplashCatPage extends StatefulWidget {

  const SplashCatPage({super.key});

  @override
  State<SplashCatPage> createState() => _SplashCatPageState();
}

class _SplashCatPageState extends State<SplashCatPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CatBreedsPage())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido a Cat Breeds!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Image.asset(
              'assets/cat.png',
              width: 180,
              height: 180,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}