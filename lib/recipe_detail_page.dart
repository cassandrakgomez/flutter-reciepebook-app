// recipe_detail_page.dart
import 'package:flutter/material.dart';
import 'main.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Ingredients:', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...recipe.ingredients.map((i) => Text('• $i')),
            const SizedBox(height: 16),
            Text('Instructions:', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(recipe.instructions),
          ],
        ),
      ),
    );
  }
}
