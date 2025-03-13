import 'package:dio/dio.dart';
import 'package:senpai_lib/core/constants/app_consts.dart';
import 'package:senpai_lib/core/error/exceptions.dart';
import 'package:senpai_lib/features/anime/data/data_sources/anime_data_service.dart';
import 'package:senpai_lib/features/anime/data/model/anime_model.dart';


class AnimeServiceImpl implements AnimeService {
  final Dio dio;

  AnimeServiceImpl(this.dio);

  @override
  Future<List<AnimeModel>> getCurrentlyWatchingAnime() async {
    try {
      final response = await dio.get(
        AppConstants.currentlyWatchingAnimeUrl,
        options: Options(
          headers: {AppConstants.contentTypeHeader: AppConstants.jsonContentType},
          sendTimeout: Duration(seconds: 10),
          receiveTimeout: Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        final data = List<Map<String, dynamic>>.from(json['data']);
        return data.map((item) => AnimeModel.fromJson(item)).toList();
      } else {
        throw ServerException(
          'Failed to load currently watching anime: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ServerException('Failed to fetch data: ${e.message}');
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<List<AnimeModel>> getTopAnime(int page) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseApiUrl}/top/anime?page=$page',
        options: Options(
          headers: {AppConstants.contentTypeHeader: AppConstants.jsonContentType},
          sendTimeout: Duration(seconds: 12),
          receiveTimeout: Duration(seconds: 12),
        ),
      );

      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        final data = List<Map<String, dynamic>>.from(json['data']);
        return data.map((item) => AnimeModel.fromJson(item)).toList();
      } else {
        throw ServerException(
          'Failed to load top anime: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ServerException('Error: ${e.message}');
    } catch (e) {
      throw ServerException('Error: $e');
    }
  }
}