import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repo_viewer/githup/presentation/repo_starred_page/widget/data_search.dart';
import 'package:github_repo_viewer/githup/presentation/repo_starred_page/widget/listitem.dart';

import '../../../core/presentation/routes/app_router.gr.dart';
import '../../data/repositories/repo_starred_repository.dart';
import 'cubit/repo_starred_cubit.dart';

class RepoStarredPage extends StatefulWidget {
  const RepoStarredPage({Key? key}) : super(key: key);

  @override
  State<RepoStarredPage> createState() => _RepoStarredPageState();
}

class _RepoStarredPageState extends State<RepoStarredPage> {
  late RepoStarredCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = RepoStarredCubit(
      repoStarredRepository: RepoStarredRepositoryImpl(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getRepoStarred(),
      child: RepoPage(
        cubit: cubit,
      ),
    );
  }
}

class RepoPage extends StatefulWidget {
  const RepoPage({
    super.key,
    required this.cubit,
  });

  final RepoStarredCubit cubit;

  @override
  State<RepoPage> createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<RepoStarredCubit>().getRepoStarred();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                showSearch(
                    context: context,
                    delegate: DataSearch(cubit: widget.cubit));
              },
              child: Text(
                'Starred repositories',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(
              'Tap to search 👆',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          BlocConsumer<RepoStarredCubit, RepoState>(
            listener: (context, state) {
              if (state.status == Status.logout) {
                AutoRouter.of(context).popAndPush(
                  const SignInRoute(),
                );
              }
            },
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context.read<RepoStarredCubit>().logout();
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.black,
                      )),
                  IconButton(
                      onPressed: () {
                        context.read<RepoStarredCubit>().refresh();
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.black,
                      )),
                ],
              );
            },
          )
        ],
      ),
      body: BlocBuilder<RepoStarredCubit, RepoState>(
        builder: (context, state) {
          switch (state.status!) {
            case Status.loading:
              return const Center(
                child: RefreshProgressIndicator(),
              );
            case Status.success:
              final repoStarred = state.repoStarred;
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedMax!
                    ? state.repoStarred!.length
                    : state.repoStarred!.length + 1,
                itemBuilder: (context, index) {
                  return index >= repoStarred!.length
                      ? const Center(child: CircularProgressIndicator())
                      : ListItem(
                          repo: repoStarred[index],
                          cubit: widget.cubit,
                        );
                  // return listrepo(repo, context);
                },
              );

            case Status.error:
              return const Center(
                child: Text('No Internet'),
              );
            case Status.logout:
              return const Center(
                child: RefreshProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
