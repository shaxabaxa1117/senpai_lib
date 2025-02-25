import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senpai_lib/feature/anime/presentation/blocs/bloc/trending_anime_bloc.dart';

import 'package:senpai_lib/injection_container.dart' as di;

class AnimeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              di.sl<TrendingAnimeBloc>()..add(LoadTrendingAnimeEvent()),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A1A1A), Color(0xFFC2185B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text(
            'Anime Explorer',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
        ),
        body: BlocBuilder<TrendingAnimeBloc, TrendingAnimeState>(
          builder: (context, state) {
            if (state is TrendingAnimeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TrendingAnimeLoaded) {
              return GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: state.animeList.length,
                itemBuilder: (context, index) {
                  final anime = state.animeList[index];
                  return GestureDetector(
                    onTap: () {
                      // Переход на детали (пока заглушка)
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              anime.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) => Icon(
                                    Icons.image,
                                    size: 60,
                                    color: Color(0xFF7B1FA2),
                                  ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            anime.title,
                            style: Theme.of(context).textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '★ ${anime.score}',
                                style: TextStyle(
                                  color: Color(0xFF7B1FA2),
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                anime.type,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(
                              Icons.favorite_border,
                              color: Color(0xFFC2185B),
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is TrendingAnimeError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('Press to load anime'));
          },
        ),
      ),
    );
  }
}
