import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_section/login.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            ],
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'WELCOME!',
                style: GoogleFonts.inriaSerif(
                    color: const Color.fromARGB(255, 235, 236, 244),
                    fontSize: 30),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Thanks for being a part of',
                style: GoogleFonts.inder(
                    color: const Color.fromARGB(255, 235, 236, 244),
                    fontSize: 20),
              ),
              Text(
                'READ.ME ',
                style: GoogleFonts.inder(
                    color: const Color.fromARGB(255, 235, 236, 244),
                    fontSize: 28),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'contents for growth  ',
                style: GoogleFonts.inder(
                    color: const Color.fromARGB(255, 235, 236, 244),
                    fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              const CircleAvatar(
                radius: 140,
                backgroundImage: AssetImage('assets/reading_book.png'),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 9, 60, 106))),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
                },
                child: Text(
                  'GET STARTED',
                  style: GoogleFonts.inder(
                      color: const Color.fromARGB(255, 235, 236, 244),
                      fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
