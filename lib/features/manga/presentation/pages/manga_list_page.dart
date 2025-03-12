


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:senpai_lib/features/manga/presentation/blocs/bloc/manga_bloc.dart';
import 'package:senpai_lib/features/manga/presentation/components/manga_card.dart';
import 'package:shimmer/shimmer.dart';


class MangaPage extends StatelessWidget {
  const MangaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Тёмный фон
      body: BlocBuilder<MangaBloc, MangaState>(
        builder: (context, state) {
          if (state is MangaLoading) {
            return Center(child: _buildLoadingEffect());
          } else if (state is MangaLoaded) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.black,
                  expandedHeight: 50,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    
                    title: const Text(
                      '🔥 Top Manga',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => MangaCard(manga: state.mangas[index]),
                      childCount: state.mangas.length,
                    ),
                  ),
                ),
              ],
            );
          } else if (state is MangaError) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Colors.white)),
            );
          }
          return Center(child: _buildLoadingEffect());
        },
      ),
    );
  }
}

  Widget _buildLoadingEffect() {
    return Column(
      children: [
        SizedBox(height: 20),


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
