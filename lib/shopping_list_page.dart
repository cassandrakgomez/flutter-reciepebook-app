// shopping_list_page.dart
import 'package:flutter/material.dart';
import 'main.dart';

class ShoppingListPage extends StatelessWidget {
  final List<Recipe> recipes;
  final Map<String, int> cart;
  final void Function(String) onAdd;
  final void Function(String) onRemove;
  final Map<String, List<String>> Function() generateShoppingList;

  const ShoppingListPage({
    super.key,
    required this.recipes,
    required this.cart,
    required this.onAdd,
    required this.onRemove,
    required this.generateShoppingList,
  });

  @override
  Widget build(BuildContext context) {
    final shoppingList = generateShoppingList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Available Recipes',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          // Section 1: Recipes with add/remove
          ...recipes.map((recipe) {
            final qty = cart[recipe.name] ?? 0;
            return Card(
              child: ListTile(
                title: Text(recipe.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => onRemove(recipe.name),
                    ),
                    Text('$qty', style: const TextStyle(fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => onAdd(recipe.name),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 10),

          const Text('Generated Shopping List',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          if (shoppingList.isEmpty)
            const Text('No items in your cart yet.'),
          if (shoppingList.isNotEmpty)
            ...shoppingList.entries.map((entry) {
              return Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.key,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 4),
                      ...entry.value.map((ingredient) => Text('• $ingredient')),
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
