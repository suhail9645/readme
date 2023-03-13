import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:read_me/admin/add_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:read_me/home_section/half_body.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:read_me/profile_section/profile.dart';
import '../fuctions/functions.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
 final bool dec=false;
  // InfiniteScrollController control=InfiniteScrollController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 46, 47, 55),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 46, 47, 55),
          title: SizedBox(
            height: 45,
            child: TextFormField(
              onTap: () {},
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.amber,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(6, 6, 0, 0),
                  hintText: 'search stories',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 9, 60, 106), width: 2)),
                  // contentPadding: EdgeInsets.all(10),
                  filled: true,
                  fillColor: Color.fromARGB(255, 68, 62, 62),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  )),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ));
            },
            icon: const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 39, 37, 37),
              child: Icon(Icons.person_2_rounded),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                ClassFunctions.getdata();
              },
              child: const Icon(Icons.refresh),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 5),
                child: Row(
                  children: [
                    Text(
                      'Trending now',
                      style: Variables.mStyle,
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
              ValueListenableBuilder(
                  valueListenable: ClassFunctions.motivation,
                  builder: (context, value, child) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: value
                              .map((e) => Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 14),
                                    child: SizedBox(
                                      height: 130,
                                      width: 140,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image: NetworkImage(e.image),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList()),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 0, 6),
                child: Text(
                  'Category',
                  style: Variables.mStyle,
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children: Variables.modelCategory,

              ),
              HalfBody()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: Variables.sStyle,
          unselectedLabelStyle: Variables.sStyle,
          backgroundColor: Color.fromARGB(57, 85, 85, 87),
           type: BottomNavigationBarType.fixed,
          items: const [
           BottomNavigationBarItem(
            
            icon: Icon(Icons.home,color: Colors.greenAccent,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy,color: Color.fromARGB(255, 164, 163, 246),),
            label: 'File',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star,color: Color.fromARGB(255, 247, 187, 7),),
            label: 'Premium',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,color: Colors.red,),
            label: 'Favorite',
          ),
  
        ]),
      ),
    );
  }
}
