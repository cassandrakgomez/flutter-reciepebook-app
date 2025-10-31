// add_recipe_page.dart
import 'package:flutter/material.dart';
import 'main.dart'; // for the Recipe class

class AddRecipePage extends StatefulWidget {
  final void Function(Recipe) onAddRecipe;
  const AddRecipePage({super.key, required this.onAddRecipe});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();
  final List<String> _ingredients = [];

  void _addIngredient() {
    final text = _ingredientController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _ingredients.add(text);
        _ingredientController.clear();
      });
    }
  }

  void _deleteIngredient(int index) => setState(() => _ingredients.removeAt(index));

  void _saveRecipe() {
    final name = _nameController.text.trim();
    final instructions = _instructionsController.text.trim();
    if (name.isEmpty || instructions.isEmpty || _ingredients.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please complete all fields')));
      return;
    }

    final recipe = Recipe(
      name: name,
      instructions: instructions,
      ingredients: List.from(_ingredients),
    );

    widget.onAddRecipe(recipe); // send back to parent

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Recipe "${recipe.name}" added!')));

    _nameController.clear();
    _instructionsController.clear();
    _ingredients.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Add a New Recipe', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Recipe Name', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _instructionsController,
            decoration: const InputDecoration(labelText: 'Instructions', border: OutlineInputBorder()),
            maxLines: 4,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ingredientController,
                  decoration: const InputDecoration(labelText: 'Ingredient', border: OutlineInputBorder()),
                  onSubmitted: (_) => _addIngredient(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: _addIngredient, child: const Text('Add')),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _ingredients.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  title: Text(_ingredients[i]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteIngredient(i),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveRecipe,
              child: const Text('Save Recipe'),
            ),
          ),
        ],
      ),
    );
  }
}
