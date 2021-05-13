class DownloadLinkModel {
  String _name;
  String _link;

  DownloadLinkModel({String name, String link}) {
    this._name = name;
    this._link = link;
  }

  String get name => _name.replaceAll(RegExp('\\s+'), " ").trim();
  String get link => _link;

  DownloadLinkModel.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _link = json['link'];
  }
}
