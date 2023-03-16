import 'package:flutter/material.dart';
import 'package:read_me/home_section/half_body.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:read_me/model/model_story.dart';
import 'package:read_me/profile_section/profile.dart';
import 'package:hive_flutter/adapters.dart';
import '../../fuctions/functions.dart';
import '../../read_section/read.dart';

class HomePageTwo extends StatelessWidget {
  const HomePageTwo({super.key});

  final bool dec = false;

  @override

  // InfiniteScrollController control=InfiniteScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox<Story>('story'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final storyDb=Hive.box<Story>('story');
            return ValueListenableBuilder(
              valueListenable: storyDb.listenable(),
              builder: (context, value, child) {
                List<Story> categoryStory =
                    ClassFunctions.sepratingStory(value, 'Motivation');
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 9, 60, 106),
                                      width: 2)),
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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: categoryStory
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 8, 14),
                                          child: SizedBox(
                                            height: 130,
                                            width: 140,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  bool isFavorite =
                                                      await ClassFunctions
                                                          .isFavorite(e.id!);
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReadPage(
                                                      story: e,
                                                      isFavorite: isFavorite,
                                                    ),
                                                  ));
                                                },
                                                child: Image(
                                                  image: NetworkImage(e.image),
                                                  fit: BoxFit.fill,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return ColoredBox(
                                                      color: Colors.black12,
                                                      child: Center(
                                                        child: Text(
                                                          e.storyname,
                                                          style:
                                                              Variables.sStyle,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList()),
                          ),
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
                           HalfBody(storyValues: value,)
                        ],
                      ),
                    ),
                    bottomNavigationBar: ValueListenableBuilder(
                      valueListenable: Variables.bottemIndex,
                      builder: (context, value, child) => BottomNavigationBar(
                          // selectedIconTheme: IconThemeData(color: Colors.red),
                          elevation: 5,
                          currentIndex: value,
                          onTap: (value) {
                            Variables.bottemIndex.value = value;
                          },
                          selectedItemColor: Color.fromARGB(255, 63, 143, 213),
                          unselectedItemColor: Colors.white,
                          backgroundColor: Color.fromARGB(57, 85, 85, 87),
                          type: BottomNavigationBarType.fixed,
                          items: [
                            BottomNavigationBarItem(
                              icon: GestureDetector(
                                  onTap: () {
                                    Variables.onTap.value = true;
                                  },
                                  child: const Icon(
                                    Icons.home,
                                    color: Color.fromARGB(255, 237, 241, 239),
                                  )),
                              label: 'Home',
                            ),
                            const BottomNavigationBarItem(
                              icon: Icon(
                                Icons.file_copy,
                                color: Color.fromARGB(255, 8, 225, 55),
                              ),
                              label: 'File',
                            ),
                            const BottomNavigationBarItem(
                              icon: Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 247, 187, 7),
                              ),
                              label: 'Premium',
                            ),
                            const BottomNavigationBarItem(
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              label: 'Favorite',
                            ),
                          ]),
                    ),
                  ),
                );
                
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
