class Search {
  String _name;
  String _link;
  String _image;
  String _release;

  Search({String name, String link, String image, String release}) {
    this._name = name;
    this._link = link;
    this._image = image;
    this._release = release;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get link => _link;
  set link(String link) => _link = link;
  String get image => _image;
  set image(String image) => _image = image;
  String get release => _release;
  set release(String release) => _release = release;

  Search.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _link = json['link'];
    _image = json['image'];
    _release = json['release'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['link'] = this._link;
    data['image'] = this._image;
    data['release'] = this._release;
    return data;
  }
}
