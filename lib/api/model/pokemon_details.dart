class PokemonDetails {
  final int id;
  final String name;

  PokemonDetails({required this.id, required this.name});

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      id: json['id'],
      name: json['name']
    );
  }
}
