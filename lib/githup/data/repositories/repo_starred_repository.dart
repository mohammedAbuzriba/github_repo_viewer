import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';

import '../../../auth/intrastructure/credentials_storage/secure_credential_storage.dart';
import '../model/repo_search_model.dart';
import '../model/repo_starred_model.dart';

abstract class RepoStarredRepository {
  Future<List<RepoStarred>> getRepoStarred();
  Future<RepoSearch> getRepositories({String? searchQuery});
}

class RepoStarredRepositoryImpl implements RepoStarredRepository {
  final secureStorage = SecureCredentialStorage(const FlutterSecureStorage());

  @override
  Future<List<RepoStarred>> getRepoStarred() async {
    const String baseeUrl = 'https://api.github.com/user/starred';
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    try {
      Credentials? credentials = await secureStorage.read();

      final response = await dio.get(
        baseeUrl,
        options: Options(
          headers: {'Authorization': 'Bearer ${credentials?.accessToken}'},
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
  Future<RepoSearch> getRepositories({
    String? searchQuery,
  }) async {
    const String baseeUrl = 'https://api.github.com/search/repositories';
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    try {
      Credentials? credentials = await secureStorage.read();
      final response = await dio.get(
        '$baseeUrl?q=$searchQuery',
        options: Options(
          headers: {'Authorization': 'Bearer ${credentials?.accessToken}'},
        ),
      );

      if (response.data != null) {
        RepoSearch repoSearch = RepoSearch.fromJson(response.data);
        return repoSearch;
      } else {
        throw Exception('repo not found');
      }
    } on DioError catch (error) {
      throw Exception('Error getting repo: $error');
    } catch (e) {
      throw Exception('repo not found');
    }
  }
}
