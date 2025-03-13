import 'package:dio/dio.dart';
import 'package:senpai_lib/core/constants/app_consts.dart';
import 'package:senpai_lib/core/error/exceptions.dart';
import 'package:senpai_lib/features/manga/data/data_source/manga_service.dart';
import 'package:senpai_lib/features/manga/data/model/manga_model.dart';

class MangaServiceImpl implements MangaService {
  final Dio dio;

  MangaServiceImpl({required this.dio});

  @override
  Future<List<MangaModel>> getTopManga(int page) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseApiUrl}/top/manga?page=$page',
        options: Options(
          headers: {AppConstants.contentTypeHeader: AppConstants.jsonContentType},
          sendTimeout: Duration(seconds: 12),
          receiveTimeout: Duration(seconds: 12),
        ),
      );

      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        final data = List<Map<String, dynamic>>.from(json['data']);
        return data.map((item) => MangaModel.fromJson(item)).toList();
      } else {
        throw ServerException(
          'Failed to load top manga: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ServerException('Error: ${e.message}');
    } catch (e) {
      throw ServerException('Error: $e');
    }
  }
}