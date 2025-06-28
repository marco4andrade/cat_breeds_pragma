import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../usecases/get_cat_breeds.dart';
import '../usecases/search_cat_breed.dart';
import '../../domain/entities/cat_breed.dart';

/// Ejemplo de widget que muestra cómo acceder a los casos de uso usando Provider
class ExampleUseCaseWidget extends StatefulWidget {
  const ExampleUseCaseWidget({super.key});

  @override
  State<ExampleUseCaseWidget> createState() => _ExampleUseCaseWidgetState();
}

class _ExampleUseCaseWidgetState extends State<ExampleUseCaseWidget> {
  List<CatBreed> breeds = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplo de Uso de Provider')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: isLoading ? null : _loadAllBreeds,
                  child: const Text('Cargar todas las razas'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: isLoading ? null : _searchBreeds,
                  child: const Text('Buscar "Persian"'),
                ),
              ],
            ),
          ),
          if (isLoading)
            const CircularProgressIndicator()
          else
            Expanded(
              child: ListView.builder(
                itemCount: breeds.length,
                itemBuilder: (context, index) {
                  final breed = breeds[index];
                  return ListTile(
                    title: Text(breed.name),
                    subtitle: Text(breed.origin),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  void _loadAllBreeds() async {
    setState(() => isLoading = true);
    
    try {
      // Ejemplo 1: Acceder al caso de uso usando Provider.of
      final getCatBreedsUseCase = Provider.of<GetCatBreedsUseCase>(context, listen: false);
      final result = await getCatBreedsUseCase();
      
      setState(() {
        breeds = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _searchBreeds() async {
    setState(() => isLoading = true);
    
    try {
      // Ejemplo 2: Acceder al caso de uso usando context.read
      final searchCatBreedUseCase = context.read<SearchCatBreedUseCase>();
      final result = await searchCatBreedUseCase('Persian');
      
      setState(() {
        breeds = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}