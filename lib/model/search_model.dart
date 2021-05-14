class SearchModel {
  String _name;
  String _link;
  String _image;
  String _release;

  SearchModel({String name, String link, String image, String release}) {
    this._name = name;
    this._link = link;
    this._image = image;
    this._release = release;
  }

  String get name => _name;
  String get link => _link;
  String get image => _image;
  String get release => _release.replaceAll(RegExp('[^0-9]'), "").trim();

  SearchModel.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _link = json['link'];
    _image = json['image'];
    _release = json['release'];
  }
}
