class FavouriteModel {
  String title;
  String img;
  String link;

  FavouriteModel({this.title, this.img, this.link});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.img = json['img'];
    this.link = json['link'];
  }

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'img': this.img,
        'link': this.link,
      };

  @override
  String toString() {
    return '\'title\': ${this.title}, \'img\': ${this.img}, \'link\': ${this.link}';
  }
}
