// main.dart
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'view_recipes_page.dart';
import 'add_recipe_page.dart';
import 'shopping_list_page.dart';

// Shared recipe model
class Recipe {
  String name;
  String instructions;
  List<String> ingredients;

  Recipe({
    required this.name,
    required this.instructions,
    required this.ingredients,
  });
}

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Recipe Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const RecipeScaffold(),
    );
  }
}

class RecipeScaffold extends StatefulWidget {
  const RecipeScaffold({super.key});

  @override
  State<RecipeScaffold> createState() => _RecipeScaffoldState();
}

class _RecipeScaffoldState extends State<RecipeScaffold> {
  int _selectedIndex = 0;
  final List<Recipe> _recipes = [];

  void _selectPage(int index) => setState(() => _selectedIndex = index);

  void _addRecipe(Recipe recipe) {
    setState(() {
      _recipes.add(recipe);
    });
  }

  void _deleteRecipe(int index) {
    setState(() {
      _recipes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      ViewRecipesPage(
        recipes: _recipes,
        onDelete: _deleteRecipe,
      ),
      AddRecipePage(onAddRecipe: _addRecipe),
      const ShoppingListPage(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Recipe Book')),
      drawer: appDrawer(context, _selectPage),
      body: IndexedStack(index: _selectedIndex, children: pages),
    );
  }
}
