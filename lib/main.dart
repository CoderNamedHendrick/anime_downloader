import 'package:anime_downloader/model/recent_search.dart';
import 'package:anime_downloader/screens/home_page.dart';
import 'package:anime_downloader/services/auth.dart';
import 'package:anime_downloader/services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  await Permission.storage.request();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(RecentSearchAdapter());
  await Hive.openBox<RecentSearch>('recentSearches');
  await runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Pōtaru',
        theme: ThemeData(
          primaryColor: const Color(0xff282828),
          accentColor: Colors.grey[700],
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            headline1: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: Provider<Database>(
          create: (_) => FirestoreDatabase(
            uid: Provider.of<AuthBase>(context, listen: false).currentUser.uid,
            email:
                Provider.of<AuthBase>(context, listen: false).currentUser.email,
          ),
          child: HomeScreen(),
        ),
      ),
    );
  }
}
