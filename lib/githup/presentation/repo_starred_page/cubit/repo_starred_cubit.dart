import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../auth/intrastructure/credentials_storage/secure_credential_storage.dart';
import '../../../data/model/repo_search_model.dart';
import '../../../data/model/repo_starred_model.dart';
import '../../../data/repositories/repo_starred_repository.dart';

part 'repo_starred_state.dart';

class RepoStarredCubit extends Cubit<RepoState> {
  final secureStorage = SecureCredentialStorage(const FlutterSecureStorage());

  final RepoStarredRepositoryImpl repoStarredRepository;
  RepoStarredCubit({required this.repoStarredRepository})
      : super(const RepoState());
  bool _isProcessing = false;

  Future<void> getRepoStarred() async {
    if (_isProcessing) return;

    _isProcessing = true;

    if (state.hasReachedMax!) {
      _isProcessing = false;
      return;
    }
    // if (state.hasReachedMax!) return;

    // emit(state.copyWith(status: Status.loading));

    try {
      final List<RepoStarred> repoStarred =
          await repoStarredRepository.getRepoStarred(state.currentPage!, 20);
      if (state.status == Status.loading) {
        emit(
          repoStarred.isEmpty
              ? state.copyWith(
                  status: Status.success,
                  hasReachedMax: true,
                )
              : state.copyWith(
                  status: Status.success,
                  repoStarred: List.of(state.repoStarred!)..addAll(repoStarred),
                  hasReachedMax: false,
                  currentPage: state.currentPage! + 1,
                ),
        );
      } else {
        emit(
          repoStarred.isEmpty
              ? state.copyWith(
                  hasReachedMax: true,
                )
              : state.copyWith(
                  status: Status.success,
                  repoStarred: List.of(state.repoStarred!)..addAll(repoStarred),
                  hasReachedMax: false,
                  currentPage: state.currentPage! + 1,
                ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: Status.error));
    }
    _isProcessing = false;
  }

  // Future<void> getRepoStarred() async {
  //   try {
  //     emit(state.copyWith(status: Status.loading));
  //     List<RepoStarred> repoStarred =
  //         await repoStarredRepository.getRepoStarred();
  //     emit(state.copyWith(repoStarred: repoStarred, status: Status.success));
  //   } catch (_) {
  //     emit(state.copyWith(status: Status.error));
  //   }
  // }

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
    emit(state.copyWith(
        status: Status.loading,
        hasReachedMax: false,
        repoStarred: [],
        currentPage: 1));
    getRepoStarred();
  }
}
