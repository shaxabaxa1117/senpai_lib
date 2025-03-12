import 'package:flutter/material.dart';
import 'package:senpai_lib/features/anime/domain/entity/anime_enity.dart';




class AnimeDetailPage extends StatelessWidget {
  final AnimeEntity chosenAnime;

  const AnimeDetailPage({ super.key, required this.chosenAnime, });

  @override
  Widget build(BuildContext context) {


    
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          // 🔥 Parallax-изображение
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 400,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                chosenAnime.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.7),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    chosenAnime.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.6),
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 📌 Контент страницы
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ⭐ Рейтинг и тип аниме
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 5),
                      Text('${chosenAnime.score}', style: TextStyle(color: Colors.white, fontSize: 16)),
                      SizedBox(width: 10),
                      Text('${chosenAnime.type} • ${chosenAnime.episodes} эп.', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: 12),

                  // 🎭 Жанры
                  Wrap(
                    spacing: 8,
                    children: chosenAnime.genres
                        .map((genre) => Chip(
                              label: Text(genre, style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.pinkAccent.withOpacity(0.7),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 16),

                  // 📜 Описание
                  Text(
                    chosenAnime.synopsis,
                    style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),

      // 🔘 Кнопки внизу
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(top: BorderSide(color: Colors.white10)),
        ),
        child: ElevatedButton(
          onPressed: () {}, // Добавить в избранное
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 5,
          ),
          child: Text(
            'Добавить в избранное',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
