import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:read_me/model_favorite/model_favorite.dart';
import 'package:read_me/splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model/model_story.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StoryAdapter().typeId)) {
    Hive.registerAdapter(StoryAdapter());
  }
  if(!Hive.isAdapterRegistered(FavoriteAdapter().typeId)){
    Hive.registerAdapter(FavoriteAdapter());
  }
//  final db=await Hive.openBox<Favorite>('favorite');
//  db.clear();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
