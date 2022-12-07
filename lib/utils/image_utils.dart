class ImageUtils {

  // Returns an image url for a poke with the given id
  static String getImage(int id) {
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  }
}
