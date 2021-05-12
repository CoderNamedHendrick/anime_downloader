class Episodes {
  String _name;
  String _link;

  String get name => _name;
  String get link => _link;

  Episodes.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _link = json['link'];
  }
}
