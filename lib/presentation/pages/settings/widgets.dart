import 'package:flutter/material.dart';

import '../home_section/variables.dart';

class CustomBottomSheetForAboutus extends Container {
  CustomBottomSheetForAboutus({super.key})
      : super(
            height: 350,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Variables.appBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'About us ',
                        style: Variables.mStyle,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 5),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          "Welcome to our story reading app! We are a team of passionate readers and writers who have come together to create an app that brings the joy of reading to people's fingertips. Our app is designed to provide a platform where readers can discover new stories,we can read pdf that in our device and share their reading experiences with others"
                          "Our goal is to make reading accessible to everyone, regardless of their location or schedule. With our app, readers can access a wide range of stories from various genres, including romance, History, Horror, and more. We strive to provide a diverse collection of stories that cater to different interests and preferences."
                          "We believe that stories have the power to inspire, educate, and entertain, and our app aims to do just that. Our team of writers is dedicated to creating engaging and thought-provoking content that captivates our readers' imagination. We also encourage aspiring writers to share their work on our app, providing a platform for them to showcase their talent and connect with readers."
                          "At our core, we are a community of readers and writers who share a love for stories. We are constantly working to improve our app and provide the best possible experience for our users. We hope that our app becomes a go-to destination for avid readers and a place where new stories and writers can be discovered.",
                          style: Variables.sStyle,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
}

class CustomListTile1 extends SizedBox {
  CustomListTile1({super.key, required text})
      : super(
            height: 40,
            child: ListTile(
              leading: const Icon(
                Icons.circle,
                size: 15,
                color: Colors.white,
              ),
              title: Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
            ));
}

class CustomListTile extends Row {
  CustomListTile({super.key, required text})
      : super(children: [
          const Icon(
            Icons.circle,
            size: 15,
            color: Colors.white,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ]);
}
