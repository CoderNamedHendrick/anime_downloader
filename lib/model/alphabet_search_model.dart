class AlphabetSearch {
  String _name;
  String _link;

  AlphabetSearch({String name, String link}) {
    this._name = name;
    this._link = link;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get link => _link;
  set link(String link) => _link = link;

  AlphabetSearch.fromJson(Map<String, dynamic> json) {
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
