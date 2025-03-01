import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:senpai_lib/feature/anime/presentation/blocs/bloc/anime_bloc.dart';
import 'package:senpai_lib/feature/anime/presentation/pages/anime_detail_page.dart';

class TrendAnimeSwipe extends StatelessWidget {
  final AnimeLoadedState state;

  const TrendAnimeSwipe({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pink.shade800,
                Colors.pink.shade900,
                Colors.black,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '🔥 Trending Now',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Swiper(
                itemCount: state.trendAnimeList.length,
                itemWidth: 300,
                itemHeight: 200,
                layout: SwiperLayout.DEFAULT,
                duration: 400,
                autoplay: true,
                autoplayDelay: 4000,
                itemBuilder: (context, index) {
                  final anime = state.trendAnimeList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => AnimeDetailPage(chosenAnime: anime),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.black,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              anime.imageUrl,
                              fit: BoxFit.cover,
                              width: 130,
                              height: double.infinity,
                              errorBuilder:
                                  (context, error, stackTrace) => Icon(
                                    Icons.broken_image,
                                    color: Colors.pinkAccent,
                                  ),
                            ),
                          ),
                          Expanded(
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
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
