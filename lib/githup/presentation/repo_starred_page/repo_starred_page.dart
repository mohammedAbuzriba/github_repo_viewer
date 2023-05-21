import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../auth/intrastructure/credentials_storage/secure_credential_storage.dart';
import '../../../core/presentation/routes/app_router.gr.dart';
import '../../data/model/repo_starred_model.dart';
import '../../data/repositories/repo_starred_repository.dart';
import 'cubit/repo_starred_cubit.dart';

class RepoStarredPage extends StatefulWidget {
  const RepoStarredPage({Key? key}) : super(key: key);

  @override
  State<RepoStarredPage> createState() => _RepoStarredPageState();
}

class _RepoStarredPageState extends State<RepoStarredPage> {
  late RepoStarredCubit cubit;
  final secureStorage = SecureCredentialStorage(const FlutterSecureStorage());

  @override
  void initState() {
    super.initState();
    cubit = RepoStarredCubit(
        repoStarredRepository: RepoStarredRepositoryImpl(),
        secureStorage: secureStorage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getRepoStarred(),
      child: WillPopScope(
        onWillPop: () async {
          cubit.refresh();
          return true;
        },
        child: Scaffold(
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
                      delegate: DataSearch(
                          cubit:
                              cubit), // You need to create a DataSearch class.
                    );
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
                    AutoRouter.of(context).push(
                      const SignInRoute(),
                    );
                  }
                },
                builder: (context, state) {
                  // if (state.status == Status.init) {
                  //   cubit.getRepoStarred();
                  // }

                  if (state.status == Status.success) {
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
                              context.read<RepoStarredCubit>().getRepoStarred();
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.black,
                            )),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
          body: BlocBuilder<RepoStarredCubit, RepoState>(
            builder: (context, state) {
              if (state.status == Status.success) {
                final repoStarred = state.repoStarred;
                print(repoStarred!.length);
                return ListView.builder(
                  itemCount:
                      repoStarred.length, // Add one for the loading indicator
                  itemBuilder: (context, index) {
                    if (index >= repoStarred.length) {
                      return const CircularProgressIndicator();
                    }
                    RepoStarred repo = repoStarred[index];
                    return listrepo(repo, context);
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  ListTile listrepo(RepoStarred repo, BuildContext context) {
    return ListTile(
      title: Text(repo.name ?? ''),
      subtitle: Text(
        repo.description ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Hero(
        tag: repo.fullName ?? '',
        child: CircleAvatar(
          backgroundImage:
              CachedNetworkImageProvider(repo.owner?.avatarUrl ?? ''),
          backgroundColor: Colors.transparent,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star_border),
          Text(
            repo.stargazersCount.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      onTap: () {
        AutoRouter.of(context)
            .push(
          RepoDetailRoute(repo: repo, fullname: repo.fullName),
        )
            .then((value) {
          cubit.refresh();
        });
      },
    );
  }
}

//* ///////////////////////////////////////////////////////
//* ///////////////////////////////////////////////////////

class DataSearch extends SearchDelegate<String> {
  final RepoStarredCubit cubit;
  DataSearch({required this.cubit});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
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
                return ListTile(
                  title: Text(repo?.name ?? ''),
                  subtitle: Text(
                    repo?.description ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: Hero(
                    tag: repo?.fullName ?? '',
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          repo?.owner?.avatarUrl ?? ''),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star_border),
                      Text(
                        repo?.stargazersCount.toString() ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  onTap: () {
                    AutoRouter.of(context)
                        .push(
                      RepoDetailRoute(repo: repo, fullname: repo?.fullName),
                    )
                        .then((value) {
                      cubit.refresh();
                    });
                  },
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
