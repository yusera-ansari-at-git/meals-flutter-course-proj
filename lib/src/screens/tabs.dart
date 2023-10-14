import 'package:flutter/material.dart';
import 'package:meals/src/models/meal.dart';
import 'package:meals/src/screens/categories.dart';
import 'package:meals/src/screens/meals.dart';
import 'package:meals/src/widgets/category_grid_item.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});
  @override
  State<Tabs> createState() {
    return _TabsState();
  }
}

class _TabsState extends State<Tabs> {
  final List<Meal> _favouriteMeals = [];
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      _favouriteMeals.remove(meal);
      _showInfoMessage("Meal is no longer a favourite");
    } else {
      _favouriteMeals.add(meal);
      _showInfoMessage("Meal added to favourites");
    }
    setState(() {});
  }

  int _selectedPageIndex = 0;
  void _selectPage(int indx) {
    setState(() {
      _selectedPageIndex = indx;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage =
        CategoriesScreen(onToggleFavourite: _toggleMealFavoriteStatus);
    String activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavourite: _toggleMealFavoriteStatus,
      );
      activePageTitle = "Your Favourites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'favourites',
          ),
        ],
        onTap: (indx) {
          _selectPage(indx);
        },
        currentIndex: _selectedPageIndex,
      ),
    );
  }
}
