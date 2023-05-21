import 'package:dio/dio.dart';

import '../model/repo_search_model.dart';
import '../model/repo_starred_model.dart';

abstract class RepoStarredRepository {
  Future<List<RepoStarred>> getRepoStarred({int page});
  Future<RepoSearch> getRepositories({String? searchQuery});
}

class RepoStarredRepositoryImpl implements RepoStarredRepository {
  @override
  Future<List<RepoStarred>> getRepoStarred({int page = 1}) async {
    const String baseeUrl = 'https://api.github.com/user/starred';
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    try {
      final response = await dio.get(
        '$baseeUrl?page=$page',
        options: Options(
          headers: {
            'Authorization': 'Bearer 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'
          },
        ),
      );
      if (response.data != null) {
        List<dynamic> data = response.data;
        List<RepoStarred> repostarred = data.map((repostarredJson) {
          return RepoStarred.fromJson(repostarredJson);
        }).toList();
        return repostarred;
      } else {
        throw Exception('repo not found');
      }
    } on DioError catch (error) {
      throw Exception('Error getting repo: $error');
    }
  }

  @override
  Future<RepoSearch> getRepositories({String? searchQuery}) async {
    const String baseeUrl = 'https://api.github.com/search/repositories';
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    try {
      final response = await dio.get(
        '$baseeUrl?q=$searchQuery',
        options: Options(
          headers: {
            'Authorization': 'Bearer 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'
          },
        ),
      );
      if (response.data != null) {
        return RepoSearch.fromJson(response.data);
      } else {
        throw Exception('repo not found');
      }
    } on DioError catch (error) {
      throw Exception('Error getting repo: $error');
    }
  }
}
