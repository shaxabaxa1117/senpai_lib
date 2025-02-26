import 'package:dio/dio.dart';
import 'package:senpai_lib/core/constants/app_consts.dart';
import 'package:senpai_lib/core/error/exceptions.dart';
import 'package:senpai_lib/feature/anime/data/data_sources/anime_data_service.dart';


class AnimeServiceImpl implements AnimeService {
  final Dio dio;

  AnimeServiceImpl(this.dio);

  @override
  Future<List<Map<String, dynamic>>> getCurrentlyWatchingAnime() async {
    try {
      final response = await dio.get(
        AppConstants.currentlyWatchingAnimeUrl,
        options: Options(headers: {AppConstants.contentTypeHeader: AppConstants.jsonContentType}),
      );

      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        return List<Map<String, dynamic>>.from(json['data']);
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
  Future<List<Map<String, dynamic>>> getTopAnime(int page) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseApiUrl}/top/anime?page=$page',
        options: Options(
          headers: {AppConstants.contentTypeHeader: AppConstants.jsonContentType},

        ),
      );

      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        return List<Map<String, dynamic>>.from(json['data']);
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
