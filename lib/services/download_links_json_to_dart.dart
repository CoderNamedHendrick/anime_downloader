class DownloadLink {
  String _name;
  String _link;

  DownloadLink({String name, String link}) {
    this._name = name;
    this._link = link;
  }

  String get name {
    _name = _name.replaceAll("\n", "").trim();
    return _name.replaceRange(8, _name.length-13, "");
  }

  String get link => _link;

  DownloadLink.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _link = json['link'];
  }
}
