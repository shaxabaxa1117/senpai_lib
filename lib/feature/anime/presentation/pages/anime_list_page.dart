import 'package:card_swiper/card_swiper.dart';
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
            return Center(child: CircularProgressIndicator(color: Colors.black));
          } else if (state is AnimeLoadedState) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  backgroundColor: Color.fromARGB(255, 186, 38, 92),
                  expandedHeight: 300,
                  floating: false,
                  pinned: true, // Закрепляет заголовок
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                    title: innerBoxIsScrolled
                        ? Text(
                            'Top Anime',
                            style: TextStyle(color: Colors.black,fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                          )
                        : null,
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Trending Now',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: Swiper(
                            itemCount: state.trendAnimeList.length,
                            itemWidth: 300,
                            itemHeight: 200,
                            layout: SwiperLayout.DEFAULT,
                            duration: 450,
                            autoplay: true,
                            autoplayDelay: 5050,
                            autoplayDisableOnInteraction: true,
                            itemBuilder: (context, index) {
                              final anime = state.trendAnimeList[index];
                              return Card(
                                color: Color(0xFF1A1A1A),
                              
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            anime.imageUrl,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                            errorBuilder: (context, error, stackTrace) => Icon(
                                              Icons.image,
                                              size: 100,
                                              color: Color(0xFF7B1FA2),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              anime.title,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              anime.synopsis,
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              body: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10, ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.7,
                ),
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
                  return Container(
                    margin: EdgeInsets.all(2),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            anime.imageUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.image,
                              size: 120,
                              color: Color(0xFF7B1FA2),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black,
                                    const Color.fromARGB(135, 0, 0, 0),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 3),
                                    child: Text(
                                      anime.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '★ ${anime.score}',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        anime.type,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
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
