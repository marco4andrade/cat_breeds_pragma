import 'package:flutter/material.dart';
import 'package:pragma_cats_breeds/presentation/widgets/circle_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/cat_breed.dart';
import '../widgets/info_cat_breed_text_page.dart';

class CatBreedDetailPage extends StatelessWidget {
  final CatBreed breed;
  const CatBreedDetailPage({Key? key, required this.breed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(breed.name, style: theme.textTheme.headlineMedium),
      ),
      body: Column(
        children: [
          breed.imageUrl?.isNotEmpty == true
              ? Image.network(
                  breed.imageUrl!,
                  width: double.infinity,
                  height: 270,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: double.infinity,
                  height: 270,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.pets, size: 80, color: Colors.grey),
                  ),
                ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  if (breed.origin != null)
                    Text('Origin: ${breed.origin!}', style: theme.textTheme.titleMedium),
                  if (breed.description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(breed.description!, style: theme.textTheme.bodyLarge),
                    ),
                  if (breed.temperament != null)
                    InfoText(label: 'Temperament', value: breed.temperament!, theme: theme),
                  if (breed.lifeSpan != null)
                    InfoText(label: 'Life span', value: '${breed.lifeSpan!} years', theme: theme),
                  if (breed.weight?.metric != null)
                    InfoText(label: 'Weight', value: breed.weight!.metric!, theme: theme),
                  CircleIndicatorRow(label: 'Intelligence', value: breed.intelligence, theme: theme),
                  CircleIndicatorRow(label: 'Adaptability', value: breed.adaptability, theme: theme),
                  CircleIndicatorRow(label: 'Affection', value: breed.affectionLevel, theme: theme),
                  CircleIndicatorRow(label: 'Dog friendly', value: breed.dogFriendly, theme: theme),
                  CircleIndicatorRow(label: 'Child friendly', value: breed.childFriendly, theme: theme),
                  CircleIndicatorRow(label: 'Energy level', value: breed.energyLevel, theme: theme),
                  CircleIndicatorRow(label: 'Health issues', value: breed.healthIssues, theme: theme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


