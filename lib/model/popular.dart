class PopularModel {
  String? _name;
  String? _link;
  String? _image;
  String? _latest;
  String? _genre;

  String get name => _name ?? '';
  String get link => _link ?? '';
  String get image => _image ?? '';
  String get latest => _latest ?? '';
  String get genre => _genre ?? '';

  PopularModel.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _link = json['link'];
    _image = json['image'];
    _latest = json['latest'];
    _genre = json['genre'];
  }
}
