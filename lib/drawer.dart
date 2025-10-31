import 'package:flutter/material.dart';

enum PageID { view, add, shopping }

Widget appDrawer(BuildContext context, void Function(int) onSelect) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.orange),
          child: Text(
            'Recipe Menu',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.menu_book),
          title: const Text('View Recipes'),
          onTap: () => onSelect(PageID.view.index),
        ),
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('Add Recipe'),
          onTap: () => onSelect(PageID.add.index),
        ),
        ListTile(
          leading: const Icon(Icons.shopping_cart),
          title: const Text('Shopping List'),
          onTap: () => onSelect(PageID.shopping.index),
        ),
      ],
    ),
  );
}
