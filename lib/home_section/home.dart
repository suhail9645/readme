import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 46, 47, 55),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 46, 47, 55),
        title: TextFormField(
          decoration: InputDecoration(
              isDense: true,
              suffix: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.search,
                  color: Colors.amber,
                ),
              ),
              hintText: 'search stories',
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 9, 60, 106), width: 2)),
              contentPadding: const EdgeInsets.all(10),
              filled: true,
              fillColor: const Color.fromARGB(255, 68, 62, 62),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              )),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 39, 37, 37),
            child: Icon(Icons.person_2_rounded),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              getdata();
            },
            child: Icon(Icons.refresh),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Text(
                    'Trending now',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Image.asset(
                    'assets/fire.png',
                    height: 15,
                  )
                ],
              ),
            ),
            CarouselSlider(items: [
              Container(
                height: 50,
                width: 50,
                color: Colors.amber,
              ),
              Container(
                height: 50,
                width: 50,
                color: Colors.black,
              ),
              Container(
                height: 50,
                width: 50,
                color: Colors.green,
              ),
              Container(
                height: 50,
                width: 50,
                color: Colors.red,
              )
            ], options: CarouselOptions(height: 40.0))
          ],
        ),
      ),
    );
  }

  Future<void> getdata() async {
//     final Query query = FirebaseFirestore.instance
//     .collection('story')
//     .where('image');

// final QuerySnapshot querySnapshot = await query.get();
// final List<QueryDocumentSnapshot> documents = querySnapshot.docs;

// // Iterate over the documents and extract the image data
// for (final QueryDocumentSnapshot document in documents) {
//   final String imageUrl = document.data().toString();
//   final String imageDescription = document.data().toString();
//   print(imageUrl);

    final _collectionRef = FirebaseFirestore.instance.collection('story');
    var value=await _collectionRef.get();
    
    
  

    }
  }

