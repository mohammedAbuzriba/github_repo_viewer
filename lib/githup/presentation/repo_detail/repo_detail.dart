import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../data/model/repo_starred_model.dart';
import '../../data/repositories/readme_repository.dart';
import 'cubit/readme_cubit.dart';

// ignore: must_be_immutable
class RepoDetailPage extends StatelessWidget {
  RepoStarred? repo;
  String? fullname;
  RepoDetailPage({Key? key, this.repo, this.fullname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReadmeCubit(readmeRepositoryImpl: ReadmeRepositoryImpl())
            ..getReadme(repo: repo, fullname: fullname),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              AutoRouter.of(context).pop();
            },
            disabledColor: Colors.black,
          ),
          title: Row(
            children: [
              Hero(
                tag: repo?.fullName ?? '',
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: CachedNetworkImageProvider(
                    repo?.owner?.avatarUrl ?? '',
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  repo?.name ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          actions: [
            BlocBuilder<ReadmeCubit, ReadmeState>(
              builder: (context, state) {
                if (state is ReadmeLoaded) {
                  return IconButton(
                    icon: Icon(
                      state.starstate ? Icons.star : Icons.star_outline,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      state.starstate
                          ? context.read<ReadmeCubit>().removStar(repo: repo)
                          : context.read<ReadmeCubit>().addStar(repo: repo);
                    },
                    disabledColor: Colors.black,
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
        body: BlocBuilder<ReadmeCubit, ReadmeState>(
          builder: (context, state) {
            if (state is ReadmeError) {
              const Center(
                child: Text('No Internet'),
              );
            }
            if (state is ReadmeLoaded) {
              return Markdown(
                data: decose(state),
                styleSheet: MarkdownStyleSheet(
                  h1: const TextStyle(fontSize: 32),
                  h2: const TextStyle(fontSize: 24),
                  h3: const TextStyle(fontSize: 20),
                  p: const TextStyle(fontSize: 16),
                  code: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Monospace',
                    backgroundColor: Colors.grey[200],
                    decoration: TextDecoration.none,
                    color: Colors.black87,
                  ),
                ),
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

  String decose(ReadmeLoaded state) {
    String base64String = '${state.readme.content}';
    base64String =
        base64String.replaceAll('\n', ''); // remove newline characters
    List<int> bytes = base64.decode(base64String);
    String decodedString = utf8.decode(bytes);
    return decodedString;
  }
}
