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
  final PokemonApi _pokemonApi = PokemonApi();
  final List<Pokemon> _pokemons = [];
  bool _isLoading = false;

  late final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 10)
        ..addListener(
          () {
            if (_scrollController.offset >=
                    _scrollController.position.maxScrollExtent &&
                !_scrollController.position.outOfRange &&
                !_isLoading) {
              loadPokemonList(_pokemons.length);
            }
          },
        );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
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
        ),
        body: Column(
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
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: _pokemons.length,
                itemBuilder: (BuildContext ctx, index) {
                  return PokemonListItem(pokemon: _pokemons[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadPokemonList(0);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void loadPokemonList(int offset) async {
    setState(() {
      _isLoading = true;
    });
    PokemonList? pokemonList = await _pokemonApi.getPokemonList(offset);
    if (pokemonList != null) {
      setState(() {
        _isLoading = false;
        _pokemons.addAll(pokemonList.pokemons);
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class PokemonListItem extends StatelessWidget {
  const PokemonListItem({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: ColorUtils.getColor(pokemon.name),
              borderRadius: BorderRadius.circular(24)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  heightFactor: 0.7,
                  child: Image.network(ImageUtils.getImage(pokemon.id)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      pokemon.name.capitalize(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        pokemon.name.capitalize(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
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
