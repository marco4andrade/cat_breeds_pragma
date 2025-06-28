import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_cats_breeds/domain/usecases/search_cat_breed.dart';
import 'package:pragma_cats_breeds/presentation/cat_breeds/bloc/cat_breeds_bloc.dart';
import 'package:pragma_cats_breeds/presentation/cat_breeds/bloc/cat_breeds_event.dart';
import 'package:pragma_cats_breeds/presentation/cat_breeds/bloc/cat_breeds_state.dart';
import 'package:pragma_cats_breeds/presentation/cat_breeds/cat_breed_detail_page.dart';
import '../../domain/entities/cat_breed.dart';
import '../../domain/usecases/get_cat_breeds.dart';

class CatBreedsPage extends StatefulWidget {

  const CatBreedsPage({
    super.key,
  });

  @override
  State<CatBreedsPage> createState() => _CatBreedsPageState();
}

class _CatBreedsPageState extends State<CatBreedsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CatBreedsBloc>().add(LoadCatBreeds());
    });
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CatBreedsBloc>(context),
      child: Scaffold(
        appBar: AppBar(title: const Text('Cat Breeds')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 30.0,
              ),
              child: Builder(
                builder: (context) => TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search breed',
                    border: const OutlineInputBorder(),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        final query = _searchController.text.trim();
                        if (query.isNotEmpty) {
                          context.read<CatBreedsBloc>().add(
                            SearchCatBreeds(query),
                          );
                        }
                      },
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            tooltip: 'Clear search',
                            onPressed: () {
                              _searchController.clear();
                              FocusScope.of(context).unfocus();
                              context.read<CatBreedsBloc>().add(ClearSearch());
                            },
                          )
                        : null,
                  ),
                  onSubmitted: (value) {
                    final query = value.trim();
                    if (query.isNotEmpty) {
                      context.read<CatBreedsBloc>().add(SearchCatBreeds(query));
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<CatBreedsBloc, CatBreedsState>(
                builder: (context, state) {
                  if (state is CatBreedsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CatBreedsError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }
                  if (state is CatBreedsLoaded) {
                    if (state.breeds.isEmpty) {
                      return const Center(
                        child: Text('There are no matches for the search'),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.breeds.length,
                      itemBuilder: (context, index) {
                        final breed = state.breeds[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CatBreedDetailPage(breed: breed),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 30.0,
                            ),
                            padding: const EdgeInsets.all(10.0),
                            width: 300,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        breed.name,
                                        style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      // const Text('Mas...'),
                                    ],
                                  ),
                                ),
                                breed.imageUrl != null &&
                                        breed.imageUrl!.isNotEmpty
                                    ? Container(
                                        height: 300,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              breed.imageUrl!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 300,
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: Icon(
                                            Icons.pets,
                                            size: 80,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                Container(
                                  margin: EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Origin: ${breed.origin}'),
                                      Text(
                                        'Intelligence: ${breed.intelligence.toString()}',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
