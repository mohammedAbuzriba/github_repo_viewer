import 'package:github_repo_viewer/githup/data/model/repo_starred_model.dart';

class RepoSearch {
  int? totalCount;
  bool? incompleteResults;
  List<RepoStarred>? items;

  RepoSearch({this.totalCount, this.incompleteResults, this.items});

  RepoSearch.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    incompleteResults = json['incomplete_results'];
    if (json['items'] != null) {
      items = <RepoStarred>[];
      json['items'].forEach((v) {
        items!.add(RepoStarred.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    data['incomplete_results'] = incompleteResults;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
