import 'package:anime_downloader/model/recent_search.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<RecentSearch> getRecentSearches() =>
      Hive.box<RecentSearch>("recentSearches");
}
