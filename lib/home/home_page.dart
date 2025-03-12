import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senpai_lib/features/anime/presentation/blocs/bloc/anime_bloc.dart';

import 'package:senpai_lib/features/anime/presentation/pages/anime_list_page.dart';
import 'package:senpai_lib/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:senpai_lib/features/auth/presentation/pages/sign_up_page.dart';
import 'package:senpai_lib/features/manga/presentation/blocs/bloc/manga_bloc.dart';
import 'package:senpai_lib/features/manga/presentation/pages/manga_list_page.dart';

import 'package:senpai_lib/home/temporary_fav_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [AnimeListPage(), FavouritePage(), MangaPage()];

  @override
  void initState() {
    super.initState();
    // Загружаем данные для начальной вкладки
    _loadInitialData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _loadDataForIndex(index);
    });
  }

  void _loadInitialData() {
    _loadDataForIndex(_selectedIndex);
  }

  void _loadDataForIndex(int index) {
    if (index == 0) {
      context.read<AnimeBloc>().add(LoadAnimeEvent());
    } else if (index == 2) {
      context.read<MangaBloc>().add(GetTopMangaEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        drawer: _buildDrawer(context),
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
          items: [
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
          selectedItemColor: Color(0xFFC2185B),
          unselectedItemColor: Colors.grey,
          backgroundColor: Color(0xFF1A1A1A),
          onTap: _onItemTapped,
        ),
      
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              String nickname = 'Guest';
              if (state is Authenticated) {
                nickname = state.user.nickname;
              }
              return UserAccountsDrawerHeader(
                accountName: Text(nickname),
                accountEmail: null,
                decoration: BoxDecoration(color: Color(0xFFC2185B)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    nickname[0].toUpperCase(),
                    style: TextStyle(fontSize: 40, color: Color(0xFFC2185B)),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Info'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Localization'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              context.read<AuthBloc>().add(SignOutEvent());
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => SignUpPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
