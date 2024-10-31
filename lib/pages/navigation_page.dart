import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_komik/bloc/navigation/navigation_bloc.dart';
import 'package:flutter_komik/bloc/search_comic/search_comic_bloc.dart';
import 'package:flutter_komik/bloc/theme/theme_bloc.dart';
import 'package:flutter_komik/bloc/validation_input/input_bloc.dart';
import 'package:flutter_komik/pages/home_page.dart';
import 'package:flutter_komik/pages/profile_page.dart';
import 'package:flutter_komik/pages/search_page.dart';
import 'package:flutter_komik/repository/comic_repo.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => InputBloc()),
        BlocProvider(
          create: (context) =>
              SearchComicBloc(ComicRepo())..add(GetSearchComic(search: "")),
        ),
      ],
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return Scaffold(
                body: IndexedStack(
                  index: state.index,
                  children: const [
                    HomePage(),
                    SearchPage(),
                    ProfilePage(),
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: state.index,
                  onTap: (value) => context
                      .read<NavigationBloc>()
                      .add(ChangePage(index: value)),
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: "Search",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: "Profile",
                    ),
                  ],
                  elevation: 0,
                  backgroundColor:
                      (themeState.isDark) ? Colors.black : Colors.white,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor:
                      (themeState.isDark) ? Colors.white : Colors.black,
                  unselectedIconTheme: const IconThemeData(size: 25),
                  selectedIconTheme: const IconThemeData(size: 30),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
