class FavouriteModel {
  String title;
  String img;
  String link;

  FavouriteModel({this.title, this.img, this.link});

  FavouriteModel.fromMap(Map<String, dynamic> data) {
    this.title = data['title'];
    this.img = data['img'];
    this.link = data['link'];
  }

  Map<String, dynamic> toMap() => {
        'title': this.title,
        'img': this.img,
        'link': this.link,
      };

  @override
  String toString() {
    return '\'title\': ${this.title}, \'img\': ${this.img}, \'link\': ${this.link}';
  }
}
