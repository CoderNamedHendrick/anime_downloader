class FireStorePath {
  static String favourite(String uid, String favouriteId) =>
      'users/$uid/favourites/$favouriteId';
  static String favourites(String uid) => 'users/$uid/favourites';
}
