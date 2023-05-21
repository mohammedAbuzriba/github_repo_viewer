import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/repo_search_model.dart';
import '../../../data/model/repo_starred_model.dart';
import '../../../data/repositories/repo_starred_repository.dart';

part 'repo_starred_state.dart';

class RepoStarredCubit extends Cubit<RepoStarredState> {
  final RepoStarredRepositoryImpl repoStarredRepository;
  RepoStarredCubit({required this.repoStarredRepository})
      : super(RepoStarredInitial());
  int currentPage = 0;
  bool hasReachedMax = false;
  Future<void> getRepoStarred({int page = 1}) async {
    if (hasReachedMax) return;
    try {
      emit(RepoStarredLoading());
      List<RepoStarred> repoStarred =
          await repoStarredRepository.getRepoStarred(page: page);
      print(repoStarred.length);
      emit(RepoStarredLoaded(
          repoStarred: repoStarred,
          currentPage: page,
          hasReachedMax: repoStarred.isEmpty));
    } catch (e) {
      emit(RepoStarredError(errorMessage: e.toString()));
    }
  }

  Future<void> getRepositories({String? searchQuery}) async {
    if (hasReachedMax) return;
    try {
      emit(RepoStarredLoading());
      RepoSearch repoStarred =
          await repoStarredRepository.getRepositories(searchQuery: searchQuery);
    } catch (e) {
      emit(RepoStarredError(errorMessage: e.toString()));
    }
  }
}
