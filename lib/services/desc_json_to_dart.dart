class Desc {
  String _id;
  String _name;
  String _type;
  String _summary;
  String _genre;
  String _release;
  String _status;
  String _otherNames;
  List<Episodes> _episodes;

  Desc(
      {String id,
        String name,
        String type,
        String summary,
        String genre,
        String release,
        String status,
        String otherNames,
        List<Episodes> episodes}) {
    this._id = id;
    this._name = name;
    this._type = type;
    this._summary = summary;
    this._genre = genre;
    this._release = release;
    this._status = status;
    this._otherNames = otherNames;
    this._episodes = episodes;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get type => _type;
  set type(String type) => _type = type;
  String get summary => _summary;
  set summary(String summary) => _summary = summary;
  String get genre => _genre;
  set genre(String genre) => _genre = genre;
  String get release => _release;
  set release(String release) => _release = release;
  String get status => _status;
  set status(String status) => _status = status;
  String get otherNames => _otherNames;
  set otherNames(String otherNames) => _otherNames = otherNames;
  List<Episodes> get episodes => _episodes;
  set episodes(List<Episodes> episodes) => _episodes = episodes;

  Desc.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _type = json['type'];
    _summary = json['summary'];
    _genre = json['genre'];
    _release = json['release'];
    _status = json['status'];
    _otherNames = json['otherNames'];
    if (json['episodes'] != null) {
      _episodes = new List<Episodes>();
      json['episodes'].forEach((v) {
        _episodes.add(new Episodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['type'] = this._type;
    data['summary'] = this._summary;
    data['genre'] = this._genre;
    data['release'] = this._release;
    data['status'] = this._status;
    data['otherNames'] = this._otherNames;
    if (this._episodes != null) {
      data['episodes'] = this._episodes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Episodes {
  String _start;
  String _end;

  Episodes({String start, String end}) {
    this._start = start;
    this._end = end;
  }

  String get start => _start;
  set start(String start) => _start = start;
  String get end => _end;
  set end(String end) => _end = end;

  Episodes.fromJson(Map<String, dynamic> json) {
    _start = json['start'];
    _end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this._start;
    data['end'] = this._end;
    return data;
  }
}
