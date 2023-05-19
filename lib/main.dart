import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:read_me/presentation/pages/login_section/bloc/login_bloc.dart';
import 'package:read_me/presentation/pages/splash_section/bloc/splash_bloc.dart';
import 'package:read_me/presentation/pages/splash_section/splash.dart';

import 'domain/model/model_story.dart';
import 'domain/model_file/model_file.dart';
import 'domain/model_user.dart/model_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await dotenv.load();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StoryAdapter().typeId)) {
    Hive.registerAdapter(StoryAdapter());
  }

  if (!Hive.isAdapterRegistered(FileCollectionAdapter().typeId)) {
    Hive.registerAdapter(FileCollectionAdapter());
  }
  if (!Hive.isAdapterRegistered(UserDataAdapter().typeId)) {
    Hive.registerAdapter(UserDataAdapter());
  }

  runApp(const MyApp());
}
 SplashBloc splashBloc=SplashBloc();
 LoginBloc loginBloc=LoginBloc();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => splashBloc,
       
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
