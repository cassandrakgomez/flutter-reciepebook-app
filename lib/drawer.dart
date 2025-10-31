import 'package:flutter/material.dart';

enum PageID { view, add, shopping }

Widget appDrawer(
  BuildContext context,
  void Function(int) onSelect, {
  required bool isDarkMode,
  required VoidCallback onToggleTheme,
}) {
  return Drawer(
    child: Column(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Color(0xff27456c)),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Recipe Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
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
        ),
        const Divider(),
        // Dark Mode Toggle
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: const Text('Dark Mode'),
          trailing: Switch(
            value: isDarkMode,
            onChanged: (_) => onToggleTheme(),
          ),
        ),
        const SizedBox(height: 12),
      ],
    ),
  );
}
