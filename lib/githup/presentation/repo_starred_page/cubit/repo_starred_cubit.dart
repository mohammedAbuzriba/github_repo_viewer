import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../auth/intrastructure/credentials_storage/secure_credential_storage.dart';
import '../../../data/model/repo_search_model.dart';
import '../../../data/model/repo_starred_model.dart';
import '../../../data/repositories/repo_starred_repository.dart';
part 'repo_starred_state.dart';

class RepoStarredCubit extends Cubit<RepoState> {
  final SecureCredentialStorage secureStorage;
  final RepoStarredRepositoryImpl repoStarredRepository;
  RepoStarredCubit(
      {required this.repoStarredRepository, required this.secureStorage})
      : super(const RepoState());
  Future<void> getRepoStarred() async {
    if (state.hasReachedMax!) return;
    try {
      emit(state.copyWith(status: Status.loading));
      List<RepoStarred> repoStarred =
          await repoStarredRepository.getRepoStarred();
      emit(state.copyWith(repoStarred: repoStarred, status: Status.success));
    } catch (_) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> getRepositories({String? searchQuery}) async {
    try {
      emit(state.copyWith(status: Status.loading));
      RepoSearch repoSearch =
          await repoStarredRepository.getRepositories(searchQuery: searchQuery);

      emit(state.copyWith(repoSearch: repoSearch, status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> logout() async {
    await secureStorage.clear();
    emit(state.copyWith(status: Status.logout));
  }

  void refresh() {
    emit(state.copyWith(status: Status.init));
    getRepoStarred();
  }
}
