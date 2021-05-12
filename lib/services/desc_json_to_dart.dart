class Desc {
  String _id;
  String _name;
  String _type;
  String _summary;
  String _genre;
  String _release;
  String _status;
  String _otherNames;
  List<EpisodesDesc> _episodes;

  Desc(
      {String id,
      String name,
      String type,
      String summary,
      String genre,
      String release,
      String status,
      String otherNames,
      List<EpisodesDesc> episodes}) {
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
  String get name => _name.replaceAll(" ", "");
  String get type =>
      _type.replaceAll("\n", "").replaceAll("\t", "");
  String get summary => _summary.replaceFirst(" ", "");
  String get genre =>
      _genre.replaceAll("\n", "").replaceAll("\t", "").replaceAll(" ", "");
  String get release => _release.replaceAll(" ", "");
  String get status => _status.replaceAll("\n", "").replaceAll(" ", "");
  String get otherNames => _otherNames.replaceAll(" ", "");
  String get episodeStart => _episodes[0].start;
  String get episodeEnd => _episodes[0].end;

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
      _episodes = new List<EpisodesDesc>();
      json['episodes'].forEach((v) {
        _episodes.add(new EpisodesDesc.fromJson(v));
      });
    }
  }
}

class EpisodesDesc {
  String _start;
  String _end;

  EpisodesDesc({String start, String end}) {
    this._start = start;
    this._end = end;
  }

  String get start => _start.replaceAll("\n", "").replaceAll(" ", "");
  String get end => _end.replaceAll("\n", "").replaceAll(" ", "");

  EpisodesDesc.fromJson(Map<String, dynamic> json) {
    _start = json['start'];
    _end = json['end'];
  }
}
