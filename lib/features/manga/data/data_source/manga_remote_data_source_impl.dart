import 'package:dio/dio.dart';
import 'package:senpai_lib/core/constants/app_consts.dart';
import 'package:senpai_lib/core/error/exceptions.dart';
import 'package:senpai_lib/features/manga/data/data_source/manga_remote_data_source.dart';
import 'package:senpai_lib/features/manga/data/model/manga_model.dart';

class MangaRemoteDataSourceImpl implements MangaRemoteDataSource {
  final Dio dio;

  MangaRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MangaModel>> getTopManga() async{
    
try {
      final response = await dio.get('${AppConstants.baseApiUrl}/top/manga');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => MangaModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load top manga: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Failed to fetch data: $e');








  }
}
}