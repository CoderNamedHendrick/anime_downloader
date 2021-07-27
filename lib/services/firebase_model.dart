class FavouriteModel {
  String img;
  String link;

  FavouriteModel({this.img, this.link});

  FavouriteModel.fromMap(Map<String, dynamic> data) {
    this.img = data['img'];
    this.link = data['link'];
  }

  Map<String, dynamic> toMap() => {
        'img': this.img,
        'link': this.link,
      };

  @override
  String toString() {
    return '\'img\': ${this.img}, \'link\': ${this.link}';
  }
}
