class LatestAnimeModel {
  String? _name;
  String? _link;
  String? _image;
  String? _episode;

  String get name => _name ?? '';
  String get link => _link ?? '';
  String get image => _image ?? '';
  String get episode => _episode ?? '';

  LatestAnimeModel.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _link = json['link'];
    _image = json['image'];
    _episode = json['episode'];
  }
}
