import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/filters_provider.dart';
import 'package:meals/src/screens/tabs.dart';
import 'package:meals/src/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });
//   @override
//   ConsumerState<FiltersScreen> createState() {
//     return _FiltersScreenState();
//   }
// }

// class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  // var _glutenFreeFilterSet = false;
  // var _lactoseFreeFilterSet = false;
  // var _vergetarianFreeFilterSet = false;
  // var _veganFreeFilterSet = false;

  // @override
  // void initState() {
  //   super.initState();
  //   final activeFilters = ref.read(filtersProvider);
  // _glutenFreeFilterSet = activeFilters[Filter.glutenFree]!;
  // _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
  // _vergetarianFreeFilterSet = activeFilters[Filter.vegetarian]!;
  // _veganFreeFilterSet = activeFilters[Filter.vegan]!;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (_) {
      //           return Tabs();
      //         },
      //       ),
      //     );
      //   }
      // }),
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body:
          // WillPopScope(
          //   onWillPop: () async {
          // ref.read(filtersProvider.notifier).setFilters({
          //   Filter.glutenFree: _glutenFreeFilterSet,
          //   Filter.lactoseFree: _lactoseFreeFilterSet,
          //   Filter.vegan: _veganFreeFilterSet,
          //   Filter.vegetarian: _vergetarianFreeFilterSet,
          // });

          // Navigator.of(context).pop({
          //   Filter.glutenFree: _glutenFreeFilterSet,
          //   Filter.lactoseFree: _lactoseFreeFilterSet,
          //   Filter.vegan: _veganFreeFilterSet,
          //   Filter.vegetarian: _vergetarianFreeFilterSet,
          // });
          //   return false;
          // },
          // child:
          Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (flag) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, flag);
              // setState(() {
              //   // _glutenFreeFilterSet = flag;
              // });
            },
            title: Text(
              "Gluten-free",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              "Only include gluten-free meals.",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (flag) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, flag);
              // setState(() {
              //   _lactoseFreeFilterSet = flag;
              // });
            },
            title: Text(
              "Lactose-free",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              "Only include Lactose-free meals.",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (flag) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, flag);
              // setState(() {
              //   _vergetarianFreeFilterSet = flag;
              // });
            },
            title: Text(
              "Vegatarian",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              "Only include vegetarian meals.",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (flag) {
              ref.read(filtersProvider.notifier).setFilter(Filter.vegan, flag);
              // setState(() {
              //   _veganFreeFilterSet = flag;
              // });
            },
            title: Text(
              "Vegan",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              "Only include Vegan meals.",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
      // ),
    );
  }
}
