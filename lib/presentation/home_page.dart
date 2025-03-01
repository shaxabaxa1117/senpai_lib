import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senpai_lib/feature/anime/presentation/blocs/bloc/anime_bloc.dart';

import 'package:senpai_lib/feature/anime/presentation/pages/anime_list_page.dart';
import 'package:senpai_lib/presentation/temporary_fav_page.dart';
import 'package:senpai_lib/presentation/temporary_manga_page.dart';
import 'package:senpai_lib/injection_container.dart' as di;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [AnimeListPage(), FavouritePage(), MangaPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AnimeBloc>()..add(LoadAnimeEvent()),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A1A1A), Color.fromARGB(255, 155, 21, 75)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text(
            'Senpai Lib',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.live_tv),
              label: 'Watching',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Manga'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFFC2185B), // Красный акцент
          unselectedItemColor: Colors.grey,
          backgroundColor: Color(0xFF1A1A1A), // Чёрный фон
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
