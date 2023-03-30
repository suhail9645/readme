
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:read_me/model_file/model_file.dart';
import 'package:read_me/model_user.dart/model_user.dart';
import 'package:read_me/splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model/model_story.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await dotenv.load();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StoryAdapter().typeId)) {
    Hive.registerAdapter(StoryAdapter());
  }
  
  if(!Hive.isAdapterRegistered(FileCollectionAdapter().typeId)){
    Hive.registerAdapter(FileCollectionAdapter());
  }
  if(!Hive.isAdapterRegistered(UserDataAdapter().typeId)){
    Hive.registerAdapter(UserDataAdapter());
  }
 
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


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
