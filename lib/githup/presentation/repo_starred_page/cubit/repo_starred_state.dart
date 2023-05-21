part of 'repo_starred_cubit.dart';

enum Status { loading, success, error, logout }

class RepoState extends Equatable {
  final List<RepoStarred>? repoStarred;
  final RepoSearch? repoSearch;
  final bool? hasReachedMax;
  final int? currentPage;
  final Status? status;

  const RepoState(
      {this.repoStarred = const [],
      this.repoSearch,
      this.hasReachedMax = false,
      this.currentPage = 1,
      this.status = Status.loading});

  @override
  List<Object?> get props =>
      [repoStarred, repoSearch, hasReachedMax, currentPage, status];

  RepoState copyWith({
    List<RepoStarred>? repoStarred,
    RepoSearch? repoSearch,
    bool? hasReachedMax,
    int? currentPage,
    Status? status,
  }) {
    return RepoState(
      repoStarred: repoStarred ?? this.repoStarred,
      repoSearch: repoSearch ?? this.repoSearch,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      status: status ?? this.status,
    );
  }
}
