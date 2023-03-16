import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:read_me/fuctions/functions.dart';
import 'package:read_me/welcome.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
   ClassFunctions.splash(context);
    return Scaffold(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                  child: Stack(children: const [
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
            const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'MADE BY 🤍 MSPK',
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(255, 255, 255, 255)),
                )),
          ],
        ),
      ),
    );
  }

  
}
