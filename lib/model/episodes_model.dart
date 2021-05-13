class EpisodeModel {
  String _name;
  String _link;

  String get name =>  _name.replaceAll(RegExp('\\s+'), ' ').trim();
  String get link => _link.trim();

  EpisodeModel.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _link = json['link'];
  }
}
