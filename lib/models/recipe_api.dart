import 'dart:convert';
import 'package:http/http.dart' as http;

class Recipe {
  final String? name;
  final String? images;
  final double? rating;
  final String? totalTime;
  final int? noOfServings;

  Recipe(
      {this.name, this.images, this.rating, this.totalTime, this.noOfServings});

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
        name: json["name"] as String,
        images: json["images"][0]["hostedLargeUrl"] as String,
        rating: json["rating"] as double,
        totalTime: json["totalTime"] as String,
        noOfServings: json["numberOfServings"] as int);
  }
  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }
}

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "f7ad9b01a6mshb737f95159a170cp1a1f62jsn029e0acbfdd5",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}
