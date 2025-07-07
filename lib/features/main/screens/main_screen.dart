import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/core/utils/app_icons.dart';
import 'package:news/features/bookmark/presentation/screens/bookmark_screen.dart';
import 'package:news/features/home/presentation/screens/home_screen.dart';
import 'package:news/features/main/providers/navigation_provider.dart';
import 'package:news/features/search/presentation/screens/search_screen.dart';
import 'package:news/features/settings/presentation/screens/settings_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomNavIndexProvider);
    List<Widget> screens = [
      HomeScreen(),
      SearchScreen(),
      BookmarkScreen(),
      SettingsScreen(),
    ];

    final icons = [
      [AppIcons.homeSelected, AppIcons.homeUnselected],
      [AppIcons.searchSelected, AppIcons.searchUnselected],
      [AppIcons.bookmarkSelected, AppIcons.bookmarkUnselected],
      [AppIcons.settingsSelected, AppIcons.settingsUnselected],
    ];

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) =>
            ref.read(bottomNavIndexProvider.notifier).state = value,
        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: List.generate(4, (i) {
          return BottomNavigationBarItem(
            icon: SvgPicture.asset(
              i == index ? icons[i][0] : icons[i][1],
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            ),
            label: '',
          );
        }),
      ),
    );
  }
}
