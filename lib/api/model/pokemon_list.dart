class PokemonList {
  final String? next;
  final String? prev;
  final List<PokemonListItem> pokemons;

  PokemonList({required this.next, required this.prev, required this.pokemons});

  factory PokemonList.fromJson(Map<String, dynamic> json) {
    return PokemonList(
        next: json["next"],
        prev: json["prev"],
        pokemons: json["results"]
            .map<PokemonListItem>((data) => PokemonListItem.fromJson(data))
            .toList() as List<PokemonListItem>);
  }
}

class PokemonListItem {
  final int id;
  final String name;
  final String url;

  PokemonListItem({required this.id, required this.name, required this.url});

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    var name = json["name"];
    var url = json["url"];

    var lastSegment =
        Uri(path: url).pathSegments.lastWhere((element) => element.isNotEmpty);
    var id = int.parse(lastSegment);

    return PokemonListItem(id: id, name: name, url: url);
  }
}
