class Readme {
  String? name;
  String? path;
  String? sha;
  int? size;
  String? url;
  String? htmlUrl;
  String? gitUrl;
  String? downloadUrl;
  String? type;
  String? content;
  String? encoding;
  Links? lLinks;

  Readme(
      {this.name,
      this.path,
      this.sha,
      this.size,
      this.url,
      this.htmlUrl,
      this.gitUrl,
      this.downloadUrl,
      this.type,
      this.content,
      this.encoding,
      this.lLinks});

  Readme.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
    sha = json['sha'];
    size = json['size'];
    url = json['url'];
    htmlUrl = json['html_url'];
    gitUrl = json['git_url'];
    downloadUrl = json['download_url'];
    type = json['type'];
    content = json['content'];
    encoding = json['encoding'];
    lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['path'] = path;
    data['sha'] = sha;
    data['size'] = size;
    data['url'] = url;
    data['html_url'] = htmlUrl;
    data['git_url'] = gitUrl;
    data['download_url'] = downloadUrl;
    data['type'] = type;
    data['content'] = content;
    data['encoding'] = encoding;
    if (lLinks != null) {
      data['_links'] = lLinks!.toJson();
    }
    return data;
  }
}

class Links {
  String? self;
  String? git;
  String? html;

  Links({this.self, this.git, this.html});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    git = json['git'];
    html = json['html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['self'] = self;
    data['git'] = git;
    data['html'] = html;
    return data;
  }
}
