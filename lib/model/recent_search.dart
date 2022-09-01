import 'package:hive/hive.dart';

part 'recent_search.g.dart';

@HiveType(typeId: 0)
class RecentSearch extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String imgUrl;

  @HiveField(2)
  late String link;
}
