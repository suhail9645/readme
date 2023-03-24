
import 'package:flutter/material.dart';
import 'package:read_me/home_section/half_body.dart';
import 'package:read_me/home_section/search.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:read_me/model/model_story.dart';
import 'package:hive_flutter/adapters.dart';
import '../../fuctions/functions.dart';
import '../../read_section/read.dart';
import '../profile_section/profile.dart';
import '../widgets/widgets.dart';

class HomePageTwo extends StatefulWidget {
 const HomePageTwo({super.key});

  @override
  State<HomePageTwo> createState() => _HomePageTwoState();
}
class _HomePageTwoState extends State<HomePageTwo> {
  bool isHome = true;
 TextEditingController search=TextEditingController();
  Box<Story>? story;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.appBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Variables.appBackground,
        title: SizedBox(
          height: 45,
          child: TextFormField(
            controller: search,
            onTap: () {
              setState(() {
                isHome = false;
              });
            },
            onChanged: (value) {
              Variables.searchvalue.value = value;
            },
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
        leading: isHome
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ));
                },
                icon: const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 39, 37, 37),
                  child: Icon(Icons.person_2_rounded),
                ),
              )
            : IconButton(
                onPressed: () {
                 search.clear();
                 FocusScope.of(context).unfocus();
                 Variables.searchvalue.value='';
                  setState(() {
                    isHome = true;
                  });
                },
                icon: const Icon(Icons.arrow_back)),
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
      body: isHome
          ? SafeArea(   
              child: FutureBuilder(
                  future: Hive.openBox<Story>('story'),
                  builder: (context, snapshot) {               
                    if (snapshot.connectionState == ConnectionState.done) {
                      final storyDb = Hive.box<Story>('story');
                      return ValueListenableBuilder(
                        valueListenable: storyDb.listenable(),
                        builder: (context, value, child) {
                          story = value;
                          List<Story> categoryStory =
                              ClassFunctions.sepratingStory(
                                  value, 'Trending now');
                          return ListView(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14, 14, 14, 5),
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 8, 14),
                                              child: SizedBox(
                                                height: 130,
                                                width: 140,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) =>
                                                            ReadPage(
                                                          story: e,
                                                        ),
                                                      ));
                                                    },
                                                    child: Image(
                                                      image:
                                                          NetworkImage(e.image),
                                                      fit: BoxFit.fill,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return ColoredBox(
                                                          color: Colors.black12,
                                                          child: Center(
                                                            child: Text(
                                                              e.storyname,
                                                              style: Variables
                                                                  .sStyle,
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
                              HalfBody(
                                storyValues: value,
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Please wait',
                          style: Variables.mStyle,
                        ),
                      );
                    }
                  }),
            )
          : SearchPage(
              story: story!,
            ),
      bottomNavigationBar: const CustomBottom(),
    );
  }
}
