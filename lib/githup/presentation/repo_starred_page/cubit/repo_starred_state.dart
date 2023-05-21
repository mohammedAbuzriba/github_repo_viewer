part of 'repo_starred_cubit.dart';

abstract class RepoStarredState extends Equatable {
  const RepoStarredState();

  @override
  List<Object> get props => [];
}

class RepoStarredInitial extends RepoStarredState {}

class RepoStarredLoading extends RepoStarredState {}

// class RepoStarredLoaded extends RepoStarredState {
//   final List<RepoStarred> repoStarred;

//   const RepoStarredLoaded({required this.repoStarred});

//   @override
//   List<Object> get props => [repoStarred];
// }
class RepoStarredLoaded extends RepoStarredState {
  final List<RepoStarred> repoStarred;
  final bool hasReachedMax;
  final int currentPage;

  const RepoStarredLoaded(
      {required this.repoStarred,
      this.hasReachedMax = false,
      this.currentPage = 1});

  @override
  List<Object> get props => [repoStarred, hasReachedMax, currentPage];
}

class PaginationSuccess extends RepoStarredState {
  final List<RepoStarred> repoStarred;
  final bool hasReachedMax;

  const PaginationSuccess(
      {required this.repoStarred, required this.hasReachedMax});

  PaginationSuccess copyWith({
    List<RepoStarred>? repoStarred,
    bool? hasReachedMax,
  }) {
    return PaginationSuccess(
      repoStarred: repoStarred ?? this.repoStarred,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class RepoStarredError extends RepoStarredState {
  final String errorMessage;

  const RepoStarredError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
