import 'package:flutter/material.dart';
import 'package:senpai_lib/features/anime/presentation/blocs/bloc/anime_bloc.dart';
import 'package:senpai_lib/features/anime/presentation/pages/anime_detail_page.dart';

class TopAnimeGrid extends StatelessWidget {

  final AnimeLoadedState state;
  final int index;
  const TopAnimeGrid({super.key, required this.state, required this.index, });

  @override
  Widget build(BuildContext context) {
     final anime = state.topAnime[index];
    return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimeDetailPage(chosenAnime: anime),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.network(
                              anime.imageUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) => Icon(
                                    Icons.broken_image,
                                    size: 120,
                                    color: Colors.pinkAccent,
                                  ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    const Color.fromARGB(84, 0, 0, 0),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                children: [
                                  Spacer(),
                                  Text(
                                    anime.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 14,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '${anime.score}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        anime.type,
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            
  }
