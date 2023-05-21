import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_me/main.dart';
import 'package:read_me/presentation/pages/admin/add_page.dart';
import 'package:read_me/presentation/pages/login_section/login.dart';
import '../main_page/home.dart';
import 'bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    splashBloc.add(SplashInitialEvent());
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is NavigateIntoAdminPageFromSplash) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const AddPage(),
          ));
        } else if (state is NavigateIntoLoginPageFromSplash) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
        } else if (state is NavigateIntoHomeFromSplash) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const FirstHome(),
          ));
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 8, 7, 77),
                Color.fromARGB(255, 38, 45, 69),
                Color.fromARGB(255, 28, 15, 15)
              ])),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                    child: Stack(children: [
                  SizedBox(
                    height: 100,
                    child: Text(
                      'READ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 224, 225, 227),
                          fontSize: 40,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Positioned(
                      top: 35,
                      left: 72,
                      child: Card(
                        color: Color.fromARGB(255, 67, 101, 182),
                        child: Text(
                          'ME',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ))
                ])),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'MADE BY 🤍 MSPK',
                    style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
