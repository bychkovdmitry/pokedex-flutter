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
  List<Pokemon> pokemons = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: buildAppBar(),
        body: buildBody(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.list, color: Colors.black),
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Pokedex",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 32,
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: pokemons.length,
            itemBuilder: (BuildContext ctx, index) {
              return buildPokemonItem(pokemons[index]);
            },
          ),
        )
      ],
    );
  }

  Widget buildPokemonItem(Pokemon pokemon) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorUtils.getColor(pokemon.name),
            borderRadius: BorderRadius.circular(24)),
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
