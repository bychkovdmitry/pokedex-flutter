import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/api/model/pokemon_details.dart';
import 'package:pokedex/api/model/pokemon_list.dart';

class PokemonApi {
  static const url = "https://pokeapi.co/api/v2/pokemon";

  http.Client client = http.Client();

  Future<PokemonList?> getPokemonList() async {
    http.Response response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body).cast<String, dynamic>();
      return PokemonList.fromJson(json);
    }
    return null;
  }

  Future<PokemonDetails?> getPokemonDetails(String url) async {
    http.Response response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body).cast<String, dynamic>();
      return PokemonDetails.fromJson(json);
    }
    return null;
  }
}
