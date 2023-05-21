import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';

import '../../../auth/intrastructure/credentials_storage/secure_credential_storage.dart';
import '../model/readme_model.dart';
import '../model/repo_starred_model.dart';

abstract class ReadmeRepository {
  Future<Readme> getReadme({
    RepoStarred? repo,
  });
  Future<bool> getStarState({
    RepoStarred? repo,
  });
  Future<bool> removeStar({
    RepoStarred? repo,
  });
  Future<bool> addStar({
    RepoStarred? repo,
  });
}

class ReadmeRepositoryImpl implements ReadmeRepository {
  final secureStorage = SecureCredentialStorage(const FlutterSecureStorage());

  @override
  Future<Readme> getReadme({
    RepoStarred? repo,
  }) async {
    const String baseeUrl = 'https://api.github.com/repos/';
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    print('00000000');
    try {
      Credentials? credentials = await secureStorage.read();
      final response = await dio.get(
        '$baseeUrl${repo?.fullName}/readme',
        options: Options(
          headers: {'Authorization': 'Bearer ${credentials?.accessToken}'},
        ),
      );
      print('11111');
      if (response.data != null) {
        Readme readme = Readme.fromJson(response.data);
        return readme;
      } else {
        throw Exception('Readme not found');
      }
    } on DioError catch (error) {
      throw Exception('Error getting Readme: $error');
    }
  }

  @override
  Future<bool> getStarState({RepoStarred? repo}) async {
    const String baseeUrl = 'https://api.github.com/user/starred/';
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    try {
      Credentials? credentials = await secureStorage.read();

      print('$baseeUrl${repo?.fullName}');
      final response = await dio.get(
        '$baseeUrl${repo?.fullName}',
        options: Options(
          headers: {'Authorization': 'Bearer ${credentials?.accessToken}'},
        ),
      );
      if (response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 404) {
        return false;
      } else {
        throw Exception('Failed to load starred state');
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return false;
      }
      throw Exception('Error getting Readme: $e');
    }
  }

  @override
  Future<bool> addStar({RepoStarred? repo}) async {
    const String baseeUrl = 'https://api.github.com/user/starred/';
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    try {
      Credentials? credentials = await secureStorage.read();

      print('$baseeUrl${repo?.fullName}');
      final response = await dio.put(
        '$baseeUrl${repo?.fullName}',
        options: Options(
          headers: {'Authorization': 'Bearer ${credentials?.accessToken}'},
        ),
      );
      if (response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 404) {
        return false;
      } else {
        throw Exception('Failed to load starred state');
      }
    } on DioError catch (error) {
      throw Exception('Error getting Readme: $error');
    }
  }

  @override
  Future<bool> removeStar({RepoStarred? repo}) async {
    const String baseeUrl = 'https://api.github.com/user/starred/';
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    try {
      Credentials? credentials = await secureStorage.read();

      final response = await dio.delete(
        '$baseeUrl${repo?.fullName}',
        options: Options(
          headers: {'Authorization': 'Bearer ${credentials?.accessToken}'},
        ),
      );
      if (response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 404) {
        return false;
      } else {
        throw Exception('Failed to load starred state');
      }
    } on DioError catch (error) {
      throw Exception('Error getting Readme: $error');
    }
  }
}
