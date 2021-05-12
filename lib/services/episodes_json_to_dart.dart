class Episodes {
  String _name;
  String _link;

  String get name => _name.replaceAll("\n", "").replaceAll("\t", "").trim();
  String get link => _link.trim();

  Episodes.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _link = json['link'];
  }
}
