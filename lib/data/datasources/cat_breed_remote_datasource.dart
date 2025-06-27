import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cat_breed_model.dart';

class CatBreedRemoteDatasource {
  static const _apiKey = 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr';

  //OBTENER LISTADO DE GATOS
  Future<List<CatBreedModel>> getCatBreeds() async {
    final response = await http.get(
      Uri.parse('https://api.thecatapi.com/v1/breeds'),
      headers: {'x-api-key': _apiKey},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CatBreedModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cat breeds');
    }
  }

  //BUSQUEDA DE GATOS
  Future<List<CatBreedModel>> searchCatBreeds( String query ) async{
    final response = await http.get(
      Uri.parse('https://api.thecatapi.com/v1/breeds/search?q=$query'),
      headers: {'x-api-key': _apiKey},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CatBreedModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search cat breeds');
    }
  }
}