import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:read_me/presentation/pages/admin/bloc/admin_bloc.dart';
import 'package:read_me/presentation/pages/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:read_me/presentation/pages/favorite_section/bloc/favourite_bloc.dart';
import 'package:read_me/presentation/pages/file_section/bloc/file_bloc.dart';
import 'package:read_me/presentation/pages/home_section/bloc/home_bloc.dart';
import 'package:read_me/presentation/pages/login_section/bloc/login_bloc.dart';
import 'package:read_me/presentation/pages/main_page/bloc/main_page_bloc.dart';
import 'package:read_me/presentation/pages/profile_section/bloc/profile_bloc.dart';
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
 HomeBloc homeBloc=HomeBloc()..add(HomePageInitalEvent());
 MainPageBloc mainPageBloc=MainPageBloc();
 ProfileBloc profileBloc =ProfileBloc();
 ProfileBodyBloc profileBodyBloc=ProfileBodyBloc();
 EditProfileBloc editProfileBloc=EditProfileBloc();
 EditProfileImageBloc editProfileImageBloc=EditProfileImageBloc();
 FavouriteBloc favouriteBloc=FavouriteBloc();
 ImageAddBloc imageAddBloc=ImageAddBloc();
 FileBloc fileBloc=FileBloc();
 AdminBloc adminBloc=AdminBloc();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => splashBloc,),
      
      BlocProvider(create: (context) => loginBloc,),
      BlocProvider(create: (context) => mainPageBloc,),
      BlocProvider(create: (context) => profileBloc,),
      BlocProvider(create: (context) => editProfileBloc,),
      BlocProvider(create: (context) => fileBloc,),
      BlocProvider(create: (context) => favouriteBloc,),
      BlocProvider(create: (context) => adminBloc,),
      // BlocProvider(create: (context) => profileBodyBloc,)
    ],
       
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
