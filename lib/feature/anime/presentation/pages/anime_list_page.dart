import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:senpai_lib/feature/anime/presentation/blocs/bloc/anime_bloc.dart';



class AnimeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AnimeBloc, AnimeState>(
        builder: (context, state) {
          if (state is AnimeLoading) {
            print('AnimeLoading');
            return Center(child: CircularProgressIndicator(color: Colors.black,));
          } 
          if (state is AnimeLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Горизонтальный список Trending Anime
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Trending Now',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.trendAnimeList.length,
                    itemBuilder: (context, index) {
                      final anime = state.trendAnimeList[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                anime.imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => Icon(
                                      Icons.image,
                                      size: 100,
                                      color: Color(0xFF7B1FA2),
                                    ),
                              ),
                            ),
                            SizedBox(height: 8),
                            SizedBox(
                              width: 100,
                              child: Text(
                                anime.title,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Вертикальный список Top Anime
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Top Anime',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.topAnime.length + (state.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == state.topAnime.length && state.hasMore) {
                        return Padding(
                          padding: EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<AnimeBloc>().add(LoadNextTopAnime());
                            },
                            child: Text('Next'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFC2185B),
                              foregroundColor: Colors.white,
                            ),
                          ),
                        );
                      }
                      final anime = state.topAnime[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
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
                          title: Text(
                            anime.title,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                '★ ${anime.score}',
                                style: TextStyle(
                                  color: Color(0xFF7B1FA2),
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                anime.type,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          trailing: Icon(
                            Icons.favorite_border,
                            color: Color(0xFFC2185B),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is AnimeError) {
            return Center(child: Text(state.message));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
