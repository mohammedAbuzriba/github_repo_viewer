import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/repo_starred_model.dart';
import '../cubit/repo_starred_cubit.dart';
import 'listitem.dart';

class DataSearch extends SearchDelegate<String> {
  final RepoStarredCubit cubit;
  DataSearch({required this.cubit});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          cubit.refresh();
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        cubit.refresh();
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Here we call the search method from our cubit with the current query
    cubit.getRepositories(searchQuery: query);

    // And build the results based on the state of our cubit
    return BlocBuilder<RepoStarredCubit, RepoState>(
      bloc: cubit,
      builder: (context, state) {
        if (state.status == Status.success) {
          return ListView.builder(
              itemCount: state.repoSearch?.items?.length ?? 0,
              itemBuilder: (context, index) {
                final repo = state.repoSearch?.items?[index];
                return ListItem(
                  repo: repo ?? RepoStarred(),
                  cubit: cubit,
                );
              });
        }

        // cubit.refresh();

        return const Center(child: RefreshProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // For the purpose of this example, we're just going to display no suggestions

    return Container();
  }
}
