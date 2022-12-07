import 'package:flutter/material.dart';

class PokemonDetailsScreen extends StatefulWidget {
  const PokemonDetailsScreen({super.key});

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
          body: const Text("Details")),
    );
  }
}
