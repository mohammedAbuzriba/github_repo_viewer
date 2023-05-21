import 'package:dio/dio.dart';

import '../model/readme_model.dart';
import '../model/repo_starred_model.dart';

abstract class ReadmeRepository {
  Future<Readme> getReadme({RepoStarred? repo});
  Future<bool> getStarState({RepoStarred? repo});
  Future<bool> removeStar({RepoStarred? repo});
  Future<bool> addStar({RepoStarred? repo});
}

class ReadmeRepositoryImpl implements ReadmeRepository {
  @override
  Future<Readme> getReadme({RepoStarred? repo}) async {
    const String baseeUrl = 'https://api.github.com/repos/';
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    try {
      print('000000000000000000000000');
      print('$baseeUrl${repo?.fullName}/readme');
      final response = await dio.get(
        '$baseeUrl${repo?.fullName}/readme',
        options: Options(
          headers: {
            'Authorization': 'Bearer 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'
          },
        ),
      );
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
      print('$baseeUrl${repo?.fullName}');
      final response = await dio.get(
        '$baseeUrl${repo?.fullName}',
        options: Options(
          headers: {
            'Authorization': 'Bearer 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'
          },
        ),
      );
      print('0000');
      if (response.statusCode == 204) {
        print('Repo is starred');
        return true;
      } else if (response.statusCode == 404) {
        print('Repo is not starred');
        return false;
      } else {
        print('0000');
        throw Exception('Failed to load starred state');
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        print('The repository is not starred.');
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
      print('$baseeUrl${repo?.fullName}');
      final response = await dio.put(
        '$baseeUrl${repo?.fullName}',
        options: Options(
          headers: {
            'Authorization': 'Bearer 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'
          },
        ),
      );
      if (response.statusCode == 204) {
        print('Repo successfully unstarred');
        return true;
      } else if (response.statusCode == 404) {
        print('Repo is not starred');
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
      print('$baseeUrl${repo?.fullName}');
      final response = await dio.delete(
        '$baseeUrl${repo?.fullName}',
        options: Options(
          headers: {
            'Authorization': 'Bearer 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'
          },
        ),
      );
      if (response.statusCode == 204) {
        print('Repo successfully unstarred');
        return true;
      } else if (response.statusCode == 404) {
        print('Repo is not starred');
        return false;
      } else {
        throw Exception('Failed to load starred state');
      }
    } on DioError catch (error) {
      throw Exception('Error getting Readme: $error');
    }
  }
}
