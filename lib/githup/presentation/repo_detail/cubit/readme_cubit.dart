import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/readme_model.dart';

import '../../../data/model/repo_starred_model.dart';
import '../../../data/repositories/readme_repository.dart';

part 'readme_state.dart';

class ReadmeCubit extends Cubit<ReadmeState> {
  final ReadmeRepositoryImpl readmeRepositoryImpl;
  ReadmeCubit({required this.readmeRepositoryImpl}) : super(ReadmeInitial());

  Future<void> getReadme({RepoStarred? repo}) async {
    try {
      emit(ReadmeLoading());
      print('66666666666');

      Readme readme = await readmeRepositoryImpl.getReadme(repo: repo);
      print('777777777777777');

      final starstate = await readmeRepositoryImpl.getStarState(repo: repo);
      print('88888888888888888888888');

      emit(ReadmeLoaded(readme: readme, starstate: starstate));
    } catch (e) {
      emit(ReadmeError(errorMessage: e.toString()));
    }
  }

  Future<void> removStar({RepoStarred? repo}) async {
    try {
      emit(ReadmeLoading());
      await readmeRepositoryImpl.removeStar(repo: repo);

      // emit(RemovStar(starstate: starstate));
      getReadme(repo: repo);
      print('88888888888888888888888');
    } catch (e) {
      emit(ReadmeError(errorMessage: e.toString()));
    }
  }

  Future<void> addStar({RepoStarred? repo}) async {
    try {
      emit(ReadmeLoading());
      await readmeRepositoryImpl.addStar(repo: repo);

      // emit(RemovStar(starstate: starstate));
      getReadme(repo: repo);
    } catch (e) {
      emit(ReadmeError(errorMessage: e.toString()));
    }
  }
}
