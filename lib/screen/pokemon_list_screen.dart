import 'package:flutter/material.dart';
import 'package:pokedex/api/model/pokemon_list.dart';
import 'package:pokedex/api/poke_api.dart';
import 'package:pokedex/screen/pokemon_details_screen.dart';
import 'package:pokedex/utils/utils.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  static const routeName = '/poke_list_screen';

  @override
  State<StatefulWidget> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  List<PokemonListItem> pokemons = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Pokedex App"),
        ),
        body: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: pokemons.length,
            itemBuilder: (BuildContext ctx, index) {
              return PokemonCard(pokemons[index]);
            }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadPokemonList();
  }

  void loadPokemonList() async {
    PokemonList? pokemonList = await PokemonApi().getPokemonList();
    if (pokemonList != null) {
      setState(() {
        pokemons = pokemonList.pokemons;
      });
    }
  }
}

class PokemonCard extends StatelessWidget {
  final PokemonListItem pokemon;

  const PokemonCard(this.pokemon, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            // color: Colors.amber,
            color: ColorUtils.getColor(pokemon.name),
            borderRadius: BorderRadius.circular(20)),
        // child: Image.network(pokemonListItem.url),
        child: Image.network(ImageUtils.getImage(pokemon.id)),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PokemonDetailsScreen(url: pokemon.url)),
        );
      },
    );
  }
}
