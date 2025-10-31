// view_recipes_page.dart
import 'package:flutter/material.dart';
import 'main.dart';
import 'recipe_detail_page.dart';

class ViewRecipesPage extends StatelessWidget {
  final List<Recipe> recipes;
  final void Function(int) onDelete;

  const ViewRecipesPage({super.key, required this.recipes, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    if (recipes.isEmpty) {
      return const Center(child: Text('No recipes yet. Add some!'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return Card(
          child: ListTile(
            title: Text(recipe.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${recipe.ingredients.length} ingredients'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailPage(recipe: recipe),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDelete(index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
