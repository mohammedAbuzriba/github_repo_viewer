import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/routes/app_router.gr.dart';
import '../../../data/model/repo_starred_model.dart';
import '../cubit/repo_starred_cubit.dart';

// ignore: must_be_immutable
class ListItem extends StatelessWidget {
  RepoStarredCubit cubit;
  RepoStarred repo;

  ListItem({super.key, required this.repo, required this.cubit});

  @override
  Widget build(BuildContext context) {
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
