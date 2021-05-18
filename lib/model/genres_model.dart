class Genres {
  String _name;
  String _link;

  Genres({String name, String link}) {
    this._name = name;
    this._link = link;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get link => _link;
  set link(String link) => _link = link;

  Genres.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['link'] = this._link;
    return data;
  }
}
