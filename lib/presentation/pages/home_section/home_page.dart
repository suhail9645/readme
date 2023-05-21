import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:read_me/core/lists.dart';
import 'package:read_me/main.dart';
import 'package:read_me/presentation/pages/home_section/widget/category_model.dart';
import 'package:read_me/presentation/pages/home_section/widget/category_page.dart';
import 'package:read_me/presentation/pages/home_section/widget/search.dart';
import 'package:read_me/presentation/pages/home_section/variables.dart';
import '../../../domain/model/model_story.dart';
import '../../../domain/repository/other.dart';
import '../profile_section/profile.dart';
import '../widgets/widgets.dart';
import 'bloc/home_bloc.dart';
import 'widget/half_body.dart';

// ignore: must_be_immutable
class HomePageTwo extends StatelessWidget {
  HomePageTwo({super.key});

  bool isHome = true;

  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is HomePageState) {
          List<Story> categoryStory = OtherAllFunctions.sepratingStory(
              state.allStories, 'Trending now');
          return Scaffold(
            backgroundColor: Variables.appBackground,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Variables.appBackground,
              title: SizedBox(
                height: width / 7,
                child: TextFormField(
                  controller: search,
                  onTap: () {
                    homeBloc.add(NavigateIntoSearcPageEvent(
                        allStories: state.allStories));
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
              leading: state.isHome
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
                        Variables.searchvalue.value = '';
                        homeBloc.add(
                            BackIntoHomeEvent(allStories: state.allStories));
                      },
                      icon: const Icon(Icons.arrow_back)),
              actions: [
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(contentText: 'Refreshing...'));
                    homeBloc.add(HomePageInitalEvent());
                  },
                  child: const Icon(Icons.refresh),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            body: state.isHome
                ? SafeArea(
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
                        CarouselSlider(
                            items: categoryStory
                                .map(
                                  (item) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(item.image),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                                height: height / 1.6,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                initialPage: 1)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 0, 0, 6),
                          child: Text(
                            'Category',
                            style: Variables.mStyle,
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 8,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemBuilder: (context, index) => CategoryModel(
                              homePageState: state,
                              image: imagesForCategory[index],
                              name: categoryNames[index]),
                        ),
                        !state.isCategoryList
                            ? HalfBody(
                                storyValues: state.allStories,
                              )
                            : CategoryPage(
                                storyValues: state.allStories,
                                categoryName: state.categoryName,
                              )
                      ],
                    ),
                  )
                : SearchPage(
                    story: state.allStories,
                  ),
            bottomNavigationBar: const CustomBottom(),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
