import 'package:flutter/material.dart';
import 'package:read_me/home_section/variables.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 330,
            width: double.infinity,
            child: Image.asset(
              'assets/MOON.jfif',
              fit: BoxFit.fill,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 23, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDtd0soCSRdpo8Y5klekJdABh4emG2P29jwg&usqp=CAU'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Variables.userEmail!,
                          style: Variables.mStyle,
                        ),
                        Text(Variables.userName!,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                        OutlinedButton(
                            style: ButtonStyle(
                                side: MaterialStatePropertyAll(
                                    BorderSide(color: Colors.white))),
                            onPressed: () {},
                            child: Text(
                              'Edit Profile',
                              style: Variables.sStyle,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, top: 9, bottom: 20),
                child: SizedBox(
                  height: 36,
                  width: 220,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          backgroundColor:
                              MaterialStatePropertyAll(Variables.mColor)),
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_forward),
                          Text(
                            'Upgrade To Premium',
                            style: Variables.sStyle,
                          ),
                          Icon(
                            Icons.star_sharp,
                            color: Colors.amber[600],
                          )
                        ],
                      )),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 46, 47, 55),
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(30),
                          topEnd: Radius.circular(30))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton.icon(
                                onPressed: () {},
                                icon:const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                label: Text(
                                  'Favorite',
                                  style: Variables.mStyle,
                                ),),
                               TextButton.icon(
                                onPressed: () {},
                                icon:const Icon(
                                  Icons.file_copy,
                                  color:Color.fromARGB(238, 28, 135, 4),
                                ),
                                label: Text(
                                  'Favorite',
                                  style: Variables.mStyle,
                                ),),
                                
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
