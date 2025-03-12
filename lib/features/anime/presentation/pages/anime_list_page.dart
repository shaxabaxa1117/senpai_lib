import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senpai_lib/features/anime/presentation/blocs/bloc/anime_bloc.dart';
import 'package:senpai_lib/features/anime/presentation/components/top_anime_grid.dart';
import 'package:senpai_lib/features/anime/presentation/components/trend_anime_swipe.dart';
import 'package:shimmer/shimmer.dart';

class AnimeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Темный фон для стильности
      body: BlocBuilder<AnimeBloc, AnimeState>(
        builder: (context, state) {
          if (state is AnimeLoading) {
            return Center(child: _buildLoadingEffect());
          } else if (state is AnimeLoadedState) {
            return NestedScrollView(
              headerSliverBuilder:
                  (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.black,
                      expandedHeight: 320,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                        title:
                            innerBoxIsScrolled
                                ? Text(
                                  '🔥 Top Anime',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                                : null,
                        background: TrendAnimeSwipe(state: state),
                      ),
                    ),
                  ],
              body: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemCount: state.topAnime.length + (state.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.topAnime.length && state.hasMore) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AnimeBloc>().add(LoadNextTopAnime());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('Load More'),
                      ),
                    );
                  }

                  return TopAnimeGrid(state: state, index: index);
                },
              ),
            );
          } else if (state is AnimeError) {
            print(state.message);
            print('ERROR ERROR ERROR'); //! желательно обработать позже
            return Center(
              child: _buildLoadingEffect()
            );
          }
          return Center(child: _buildLoadingEffect());
        },
      ),
    );
  }

  Widget _buildLoadingEffect() {
    return Column(
      children: [
        SizedBox(height: 20),
        // 🔥 Первый ряд — широкий баннер для трендового аниме
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[850]!,
            highlightColor: Colors.grey[700]!,
            period: Duration(milliseconds: 1200),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.image_outlined,
                color: Colors.grey[700],
                size: 70,
              ),
            ),
          ),
        ),

        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: 6, // Просто заглушка на время загрузки
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[500]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
