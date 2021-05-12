class Episodes {
  String _name;
  String _link;

  String get name {
    _name = _name.replaceAll("\n", "").replaceAll("\t", "").trim();
    return _name.replaceRange(4, _name.length-4, "");
  }

  String get link => _link.trim();

  Episodes.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _link = json['link'];
  }
}
