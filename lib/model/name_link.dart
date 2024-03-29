class NameLinkModel {
  String? _name;
  String? _link;

  String get name =>  _name?.replaceAll(RegExp('\\s+'), ' ').trim() ?? '';
  String get link => _link?.trim() ?? '';

  NameLinkModel.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _link = json['link'];
  }
}
