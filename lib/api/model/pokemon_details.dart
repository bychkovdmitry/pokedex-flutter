class PokemonDetails {
  final int id;
  final String name;
  final List<String> types;

  PokemonDetails({required this.id, required this.name, required this.types});

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
        id: json['id'],
        name: json['name'],
        types: json['types']
            .map<String>((data) => data["type"]["name"] as String)
            .toList() as List<String>);
  }
}
