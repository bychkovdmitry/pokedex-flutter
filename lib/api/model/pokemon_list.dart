class PokemonList {
  final String? next;
  final String? prev;
  final List<Pokemon> pokemons;

  PokemonList({
    required this.next,
    required this.prev,
    required this.pokemons,
  });

  factory PokemonList.fromJson(Map<String, dynamic> json) {
    return PokemonList(
        next: json["next"],
        prev: json["prev"],
        pokemons: json["results"]
            .map<Pokemon>((item) => Pokemon.fromJson(item))
            .toList() as List<Pokemon>);
  }
}

class Pokemon {
  final int id;
  final String name;
  final String url;

  Pokemon({
    required this.id,
    required this.name,
    required this.url,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    var name = json["name"];
    var url = json["url"];
    var id = int.parse(
      Uri(path: url).pathSegments.lastWhere((element) => element.isNotEmpty),
    );
    return Pokemon(id: id, name: name, url: url);
  }
}
