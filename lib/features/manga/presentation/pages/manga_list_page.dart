


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:senpai_lib/features/manga/presentation/blocs/bloc/manga_bloc.dart';
import 'package:senpai_lib/features/manga/presentation/components/manga_card.dart';

import 'package:shimmer/shimmer.dart';


class MangaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<MangaBloc, MangaState>(
        builder: (context, state) {
          if (state is MangaLoading) {
            return _buildLoadingEffect();
          } else if (state is MangaLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                Expanded(child: _buildMangaGrid(state, context)),
              ],
            );
          } else if (state is MangaError) {
            return Center(
              child: Text(
                'Ошибка: ${state.message}',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return _buildLoadingEffect();
        },
      ),
    );
  }

  /// Заголовок "🔥 Top Manga"
  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        '🔥 Top Manga',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }


  Widget _buildMangaGrid(MangaLoadedState state, BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      itemCount: state.topManga.length + (state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.topManga.length && state.hasMore) {
          return _buildLoadMoreButton(context);
        }
        return MangaCard(manga: state.topManga[index]);
      },
    );
  }

  /// Кнопка "Load More"
  Widget _buildLoadMoreButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<MangaBloc>().add(LoadNextTopManga());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text('Load More'),
      ),
    );
  }

  /// Заглушка-загрузка с эффектом "Shimmer"
  Widget _buildLoadingEffect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(), // Показываем заголовок даже во время загрузки
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: 6, // Заглушка на 6 элементов
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