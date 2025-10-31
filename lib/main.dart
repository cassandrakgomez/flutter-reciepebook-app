// main.dart
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'view_recipes_page.dart';
import 'add_recipe_page.dart';
import 'shopping_list_page.dart';

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

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Recipe Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange, brightness: Brightness.dark),
        brightness: Brightness.dark,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: RecipeScaffold(
        isDarkMode: _isDarkMode,
        onToggleTheme: () => setState(() => _isDarkMode = !_isDarkMode),
      ),
    );
  }
}

class RecipeScaffold extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const RecipeScaffold({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<RecipeScaffold> createState() => _RecipeScaffoldState();
}

class _RecipeScaffoldState extends State<RecipeScaffold> {
  int _selectedIndex = 0;
  final List<Recipe> _recipes = [];
  final Map<String, int> _cart = {};

  void _selectPage(int index) => setState(() => _selectedIndex = index);

  void _addRecipe(Recipe recipe) => setState(() => _recipes.add(recipe));

  void _deleteRecipe(int index) => setState(() {
        _cart.remove(_recipes[index].name);
        _recipes.removeAt(index);
      });

  void _addToCart(String recipeName) =>
      setState(() => _cart.update(recipeName, (qty) => qty + 1, ifAbsent: () => 1));

  void _removeFromCart(String recipeName) => setState(() {
        if (_cart.containsKey(recipeName)) {
          if (_cart[recipeName]! > 1) {
            _cart[recipeName] = _cart[recipeName]! - 1;
          } else {
            _cart.remove(recipeName);
          }
        }
      });

  Map<String, List<String>> _generateShoppingList() {
    final Map<String, List<String>> shoppingList = {};
    for (var recipe in _recipes) {
      if (_cart.containsKey(recipe.name)) {
        shoppingList[recipe.name] = recipe.ingredients;
      }
    }
    return shoppingList;
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      ViewRecipesPage(recipes: _recipes, onDelete: _deleteRecipe),
      AddRecipePage(onAddRecipe: _addRecipe),
      ShoppingListPage(
        recipes: _recipes,
        cart: _cart,
        onAdd: _addToCart,
        onRemove: _removeFromCart,
        generateShoppingList: _generateShoppingList,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Recipe Book')),
      drawer: appDrawer(
        context,
        _selectPage,
        isDarkMode: widget.isDarkMode,
        onToggleTheme: widget.onToggleTheme,
      ),
      body: IndexedStack(index: _selectedIndex, children: pages),
    );
  }
}
