class Popular {
  String _name;
  String _link;
  String _image;
  String _latest;
  String _genre;

  Popular(
      {String name, String link, String image, String latest, String genre}) {
    this._name = name;
    this._link = link;
    this._image = image;
    this._latest = latest;
    this._genre = genre;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get link => _link;
  set link(String link) => _link = link;
  String get image => _image;
  set image(String image) => _image = image;
  String get latest => _latest;
  set latest(String latest) => _latest = latest;
  String get genre => _genre;
  set genre(String genre) => _genre = genre;

  Popular.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _link = json['link'];
    _image = json['image'];
    _latest = json['latest'];
    _genre = json['genre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['link'] = this._link;
    data['image'] = this._image;
    data['latest'] = this._latest;
    data['genre'] = this._genre;
    return data;
  }
}
