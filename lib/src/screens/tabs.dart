import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/provider/favourite-meals.dart';
import 'package:meals/provider/filters_provider.dart';
import 'package:meals/provider/meals_provider.dart';
import 'package:meals/src/models/meal.dart';
import 'package:meals/src/screens/categories.dart';
import 'package:meals/src/screens/filters.dart';
import 'package:meals/src/screens/meals.dart';
import 'package:meals/src/widgets/category_grid_item.dart';
import 'package:meals/src/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});
  @override
  ConsumerState<Tabs> createState() {
    return _TabsState();
  }
}

class _TabsState extends ConsumerState<Tabs> {
  // final List<Meal> _favouriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;
  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //     ),
  //   );
  // }

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = _favouriteMeals.contains(meal);
  //   if (isExisting) {
  //     _favouriteMeals.remove(meal);
  //     _showInfoMessage("Meal is no longer a favourite");
  //   } else {
  //     _favouriteMeals.add(meal);
  //     _showInfoMessage("Meal added to favourites");
  //   }
  //   setState(() {});
  // }

  int _selectedPageIndex = 0;
  void _selectPage(int indx) {
    setState(() {
      _selectedPageIndex = indx;
    });
  }

  void _setScreen(String indentifier) async {
    Navigator.pop(context);
    if (indentifier == "filters") {
      final result = await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (_) {
            return FiltersScreen(
              currentFilters: _selectedFilters,
            );
          },
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    String activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);

      activePage = MealsScreen(
        meals: favouriteMeals,
      );
      activePageTitle = "Your Favourites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
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
