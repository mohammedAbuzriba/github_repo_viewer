// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// import '../../../core/presentation/routes/app_router.gr.dart';
// import '../../data/model/repo_starred_model.dart';
// import '../../data/repositories/repo_starred_repository.dart';
// import 'cubit/repo_starred_cubit.dart';

// class RepoStarredPage extends StatelessWidget {
//   const RepoStarredPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final scrollController = ScrollController();

//     return BlocProvider(
//       create: (context) =>
//           RepoStarredCubit(repoStarredRepository: RepoStarredRepositoryImpl())
//             ..getRepoStarred(),
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Starred repositories',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               Text(
//                 'Tap to search 👆',
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//             ],
//           ),
//           actions: [
//             BlocBuilder<RepoStarredCubit, RepoStarredState>(
//               builder: (context, state) {
//                 if (state is RepoStarredLoaded) {
//                   final repoStarred = state.repoStarred;

//                   return IconButton(
//                       onPressed: () {
//                         context.read<RepoStarredCubit>().getRepoStarred();
//                       },
//                       icon: const Icon(
//                         Icons.refresh,
//                         color: Colors.black,
//                       ));
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             )
//           ],
//         ),
//         body: BlocBuilder<RepoStarredCubit, RepoStarredState>(
//           builder: (context, state) {
//             if (state is RepoStarredLoaded) {
//               final repoStarred = state.repoStarred;

//               return
// ListView.builder(
//     itemCount: repoStarred.length,
//     itemBuilder: (context, index) {
//       RepoStarred repo = repoStarred[index];
//       return ListTile(
//         title: Text(repo.name ?? ''),
//         subtitle: Text(
//           repo.description ?? '',
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//         leading: Hero(
//           tag: repo.fullName ?? '',
//           child: CircleAvatar(
//             backgroundImage: CachedNetworkImageProvider(
//                 repo.owner?.avatarUrl! ?? ''),
//             backgroundColor: Colors.transparent,
//           ),
//         ),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.star_border),
//             Text(
//               repo.stargazersCount.toString(),
//               style: Theme.of(context).textTheme.bodySmall,
//             ),
//           ],
//         ),
//         onTap: () {
//           AutoRouter.of(context).push(
//             RepoDetailRoute(repo: repo),
//           );
//         },
//       );
//     },
//   );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/routes/app_router.gr.dart';
import '../../data/model/repo_starred_model.dart';
import '../../data/repositories/repo_starred_repository.dart';
import 'cubit/repo_starred_cubit.dart';

class RepoStarredPage extends StatelessWidget {
  const RepoStarredPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<RepoStarredCubit>().getRepoStarred(
            page: (context.read<RepoStarredCubit>().state as RepoStarredLoaded)
                    .currentPage +
                1);
      }
    });

    return BlocProvider(
      create: (context) =>
          RepoStarredCubit(repoStarredRepository: RepoStarredRepositoryImpl())
            ..getRepoStarred(),
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
                        context), // You need to create a DataSearch class.
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
            BlocBuilder<RepoStarredCubit, RepoStarredState>(
              builder: (context, state) {
                if (state is RepoStarredLoaded) {
                  final repoStarred = state.repoStarred;

                  return IconButton(
                      onPressed: () {
                        context.read<RepoStarredCubit>().getRepoStarred();
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.black,
                      ));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
        body: BlocBuilder<RepoStarredCubit, RepoStarredState>(
          builder: (context, state) {
            if (state is RepoStarredLoaded) {
              final repoStarred = state.repoStarred;

              return ListView.builder(
                controller: scrollController,
                itemCount:
                    repoStarred.length + 1, // Add one for the loading indicator
                itemBuilder: (context, index) {
                  if (index >= repoStarred.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  RepoStarred repo = repoStarred[index];
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
                        backgroundImage: CachedNetworkImageProvider(
                            repo.owner?.avatarUrl! ?? ''),
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
                      AutoRouter.of(context).push(
                        RepoDetailRoute(repo: repo),
                      );
                    },
                  );
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
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final BuildContext blocContext;

  DataSearch(this.blocContext);

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
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    blocContext
        .read<RepoStarredCubit>()
        .getRepositories(searchQuery: query); // Call your search method here.
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}








// class RepoStarredPage extends StatelessWidget {
//   const RepoStarredPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final scrollController = ScrollController();

//     scrollController.addListener(() {
//       if (scrollController.position.pixels ==
//           scrollController.position.maxScrollExtent) {
//         context.read<RepoStarredCubit>().getRepoStarred(
//             page: (context.read<RepoStarredCubit>().state as RepoStarredLoaded)
//                     .currentPage +
//                 1);
//       }
//     });

//     return BlocProvider(
//       create: (context) =>
//           RepoStarredCubit(repoStarredRepository: RepoStarredRepositoryImpl())
//             ..getRepoStarred(),
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Starred repositories',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               Text(
//                 'Tap to search 👆',
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//             ],
//           ),
//           actions: [
//             BlocBuilder<RepoStarredCubit, RepoStarredState>(
//               builder: (context, state) {
//                 if (state is RepoStarredLoaded) {
//                   final repoStarred = state.repoStarred;

//                   return IconButton(
//                       onPressed: () {
//                         context.read<RepoStarredCubit>().getRepoStarred();
//                       },
//                       icon: const Icon(
//                         Icons.refresh,
//                         color: Colors.black,
//                       ));
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             )
//           ],
//         ),
//         
//body: BlocBuilder<RepoStarredCubit, RepoStarredState>(
//           builder: (context, state) {
//             if (state is RepoStarredLoaded) {
//               final repoStarred = state.repoStarred;

//               return ListView.builder(
//                 controller: scrollController,
//                 itemCount:
//                     repoStarred.length + 1, // Add one for the loading indicator
//                 itemBuilder: (context, index) {
//                   if (index >= repoStarred.length) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   RepoStarred repo = repoStarred[index];
//                   return ListTile(
//                     title: Text(repo.name ?? ''),
//                     subtitle: Text(
//                       repo.description ?? '',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     leading: Hero(
//                       tag: repo.fullName ?? '',
//                       child: CircleAvatar(
//                         backgroundImage: CachedNetworkImageProvider(
//                             repo.owner?.avatarUrl! ?? ''),
//                         backgroundColor: Colors.transparent,
//                       ),
//                     ),
//                     trailing: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(Icons.star_border),
//                         Text(
//                           repo.stargazersCount.toString(),
//                           style: Theme.of(context).textTheme.bodySmall,
//                         ),
//                       ],
//                     ),
//                     onTap: () {
//                       AutoRouter.of(context).push(
//                         RepoDetailRoute(repo: repo),
//                       );
//                     },
//                   );
//                 },
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
