part of 'readme_cubit.dart';

abstract class ReadmeState extends Equatable {
  const ReadmeState();

  @override
  List<Object> get props => [];
}

class ReadmeInitial extends ReadmeState {}

class ReadmeLoading extends ReadmeState {}

class ReadmeLoaded extends ReadmeState {
  final Readme readme;
  final bool starstate;
  const ReadmeLoaded({required this.readme, required this.starstate});

  @override
  List<Object> get props => [readme];
}

class StarState extends ReadmeState {
  final bool starstate;

  const StarState({required this.starstate});

  @override
  List<Object> get props => [starstate];
}

class AddStar extends ReadmeState {
  final bool starstate;

  const AddStar({required this.starstate});

  @override
  List<Object> get props => [starstate];
}

class RemovStar extends ReadmeState {
  final bool starstate;

  const RemovStar({required this.starstate});

  @override
  List<Object> get props => [starstate];
}

class ReadmeError extends ReadmeState {
  final String errorMessage;

  const ReadmeError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
