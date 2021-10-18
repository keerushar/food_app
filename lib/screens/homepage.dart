import 'package:api_integration/models/recipe_api.dart';
import 'package:api_integration/widgets/recipe_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe>? _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.restaurant_menu),
            SizedBox(
              width: 10,
            ),
            Text("Food Recipes"),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _recipes!.length,
              itemBuilder: (context, i) {
                return RecipeCard(
                  title: _recipes![i].name!,
                  cookTime: _recipes![i].totalTime!,
                  rating: _recipes![i].rating.toString(),
                  thumbnailUrl: _recipes![i].images!,
                  noOfServings: _recipes![i].noOfServings.toString(),
                );
              },
            ),
    );
  }
}
