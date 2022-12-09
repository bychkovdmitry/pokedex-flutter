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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon:
                  const Icon(Icons.heart_broken_outlined, color: Colors.white),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: FutureBuilder(
          builder: (ctx, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return PokemonDetailsPage(pokemonDetails: snapshot.data!);
            }
          },
          future: PokemonApi().getPokemonDetails(widget.url),
        ),
      ),
    );
  }
}

class PokemonDetailsPage extends StatelessWidget {
  final PokemonDetails pokemonDetails;

  const PokemonDetailsPage({
    Key? key,
    required this.pokemonDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorUtils.getColor(pokemonDetails.name),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 80),
          buildPokemonName(pokemonDetails),
          const SizedBox(height: 16),
          buildPokemonTypes(pokemonDetails),
          const SizedBox(height: 144),
          buildPokemonImage(pokemonDetails),
          buildPokemonTabs(pokemonDetails),
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
          spacing: 8,
          runSpacing: 8,
          children: pokemonDetails.types.map((item) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                item,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildPokemonImage(PokemonDetails pokemonDetails) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 64,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
        ),
        Positioned(
            right: 0,
            bottom: 8,
            left: 0,
            child: SizedBox(
              height: 196,
              child: Image.network(ImageUtils.getImage(pokemonDetails.id),
                  fit: BoxFit.fitHeight),
            )),
      ],
    );
  }

  Widget buildPokemonTabs(PokemonDetails pokemonDetails) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              TabBar(
                indicatorColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: DetailTabs.values.map((item) {
                  return Tab(
                    icon: Text(
                      item.name,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  );
                }).toList(),
              ),
              Expanded(
                child: TabBarView(
                  children: DetailTabs.values.map((item) {
                    if (item == DetailTabs.about) {
                      return buildAboutPage(pokemonDetails);
                    } else {
                      return buildFallbackPage(item.name);
                    }
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFallbackPage(String name) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildAboutPage(PokemonDetails pokemonDetails) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                buildAboutPageRow('Height', '${pokemonDetails.height} m'),
                buildAboutPageRow('Weight', '${pokemonDetails.weight} kg'),
                buildAboutPageRow(
                    'Abilities',
                    pokemonDetails.abilities
                        .map((item) => item.capitalize())
                        .join(", ")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAboutPageRow(String text, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 25),
          Text(value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              )),
        ],
      ),
    );
  }
}

enum DetailTabs {
  about(name: "About"),
  baseStats(name: "Base Stats"),
  evolution(name: "Evolution"),
  moves(name: "Moves");

  const DetailTabs({
    required this.name,
  });

  final String name;
}
