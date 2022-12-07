import 'package:flutter/material.dart';
import 'package:pokedex/api/model/pokemon_details.dart';
import 'package:pokedex/api/poke_api.dart';
import 'package:pokedex/utils/utils.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final String url;

  const PokemonDetailsScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  static const routeName = '/poke_details_screen';

  @override
  State<StatefulWidget> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Pokedex App"),
        ),
        body: FutureBuilder(
            builder: (ctx, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return buildPokemonDetails(snapshot.data!);
              }
            },
            future: PokemonApi().getPokemonDetails(widget.url)),
      ),
    );
  }

  Widget buildPokemonDetails(PokemonDetails pokemonDetails) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorUtils.getColor(pokemonDetails.name),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 16),
          buildPokemonName(pokemonDetails),
          const SizedBox(height: 16),
          buildPokemonTypes(pokemonDetails),
          const SizedBox(height: 16),
          Image.network(ImageUtils.getImage(pokemonDetails.id))
        ],
      ),
    );
  }

  Widget buildPokemonName(PokemonDetails pokemonDetails) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          pokemonDetails.name.capitalize(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 32,
          ),
        ),
      ),
    );
  }

  Widget buildPokemonTypes(PokemonDetails pokemonDetails) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: pokemonDetails.types.map(buildPokemonType).toList()),
      ),
    );
  }

  Widget buildPokemonType(String label) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // child: Center(
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }
}
