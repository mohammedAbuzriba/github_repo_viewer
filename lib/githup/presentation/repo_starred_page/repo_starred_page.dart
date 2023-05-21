import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:github_repo_viewer/githup/presentation/repo_starred_page/widget/data_search.dart';
import 'package:github_repo_viewer/githup/presentation/repo_starred_page/widget/listitem.dart';

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
                    return ListItem(
                      repo: repo,
                      cubit: cubit,
                    );
                    // return listrepo(repo, context);
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
}
