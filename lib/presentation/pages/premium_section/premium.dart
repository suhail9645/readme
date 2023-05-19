import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home_section/variables.dart';
import '../widgets/widgets.dart';
import 'package:lottie/lottie.dart';

class PremiumPage extends StatelessWidget {
 const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Variables.mColor,
        title: Text(
          'Premium',
          style: Variables.mStyle,
        ),
        centerTitle: true,
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: Variables.appBackground,
      body: Stack(
        children: [
          Container(
            height: 110,
            width: double.infinity,
            color: Variables.mColor,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 103, 100, 100),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      child: Text(
                        'Thank you for your interest in our premium section! Our team is currently working on enhancing and expanding our premium content to provide you with the best possible experience. Please stay tuned for updates, and feel free to contact us if you have any questions or suggestions. We appreciate your patience and support.',
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: height / 2.8,
              left: width / 15,
              child: Lottie.network(
                  'https://assets10.lottiefiles.com/packages/lf20_oo3N9WVAgU.json',
                  height: height / 2.4))
        ],
      ),
      bottomNavigationBar: const CustomBottom(),
    );
  }
}
