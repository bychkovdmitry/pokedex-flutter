class PokemonDetails {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<String> types;
  final List<String> abilities;

  PokemonDetails({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      types: json['types']
          .map<String>((item) => item["type"]["name"] as String)
          .toList() as List<String>,
      abilities: json['abilities']
          .map<String>((item) => item["ability"]["name"] as String)
          .toList() as List<String>,
    );
  }
}
