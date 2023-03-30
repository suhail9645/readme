import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:read_me/login_section/login.dart';
import 'package:read_me/register_section/register_functions.dart';
import 'package:read_me/register_section/register_widget.dart';
import 'package:read_me/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool load = false;
  File? userImage;
  String? extension;
  String? oldUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;

    double imgHeight = height / 3;
    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Image.asset(
                'assets/download_1.jfif',
                width: double.infinity,
                height: imgHeight,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/download_2.jfif',
                width: double.infinity,
                height: imgHeight,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/download_3.jfif',
                width: double.infinity,
                height: imgHeight,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(204, 13, 13, 15),
        ),
        Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(
                height: height / 15,
              ),
              Center(
                child: Text(
                  'Register',
                  style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 235, 236, 244),
                      fontSize: 28,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Center(
                child: Text(
                  'Create a new account',
                  style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 235, 236, 244),
                      fontSize: 20),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 130,
                                width: double.infinity,
                                color: Variables.appBackground,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () async {
                                          userImage = await RegisterFunction
                                              .imagePicking(
                                                  ImageSource.gallery);
                                          if (userImage != null) {
                                            extension =
                                                userImage!.path.split('.').last;
                                          }
                                          setState(() {
                                            userImage = userImage;
                                          });
                                        },
                                        child: SizedBox(
                                          width: 120,
                                          child: Row(
                                            children: const [
                                              Text(
                                                'From Gallery',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Icon(Icons.photo,
                                                  color: Colors.white)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () async {
                                          userImage = await RegisterFunction
                                              .imagePicking(ImageSource.camera);
                                          setState(() {
                                            userImage = userImage;
                                          });
                                        },
                                        child: SizedBox(
                                          width: 120,
                                          child: Row(
                                            children: const [
                                              Text(
                                                'From Camera',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Icon(Icons.camera,
                                                  color: Colors.white)
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: userImage == null
                              ? const AssetImage('assets/profile_dummy.jpg')
                              : FileImage(File(userImage!.path))
                                  as ImageProvider,
                          radius: 70,
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                      padding: const EdgeInsets.fromLTRB(14, 10, 5, 0),
                      text: 'Enter Full name'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                    child: TextFormField(
                      controller: _name,
                      decoration: const CustomFormDecoration(hint: 'eg:suhail'),
                      validator: (value) =>
                          RegisterFunction.validateFunction(value),
                    ),
                  ),
                  CustomText(
                      padding: const EdgeInsets.fromLTRB(14, 10, 5, 0),
                      text: 'Enter Username'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                    child: TextFormField(
                      controller: _username,
                      decoration: const CustomFormDecoration(hint: 'eg:mspk12'),
                      validator: (value) =>
                          RegisterFunction.validateFunction(value),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      padding: const EdgeInsets.fromLTRB(14, 10, 5, 0),
                      text: 'Enter Gmail'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                    child: TextFormField(
                      controller: _email,
                      decoration:
                          const CustomFormDecoration(hint: 'eg:mspk@gmail.com'),
                      validator: (value) =>
                          RegisterFunction.validateFunction(value),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      padding: const EdgeInsets.fromLTRB(14, 10, 5, 0),
                      text: 'Enter Password'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                    child: TextFormField(
                      controller: _password,
                      decoration: const CustomFormDecoration(hint: 'eg:123456'),
                      validator: (value) =>
                          RegisterFunction.validateFunction(value),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 20, 14, 0),
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 9, 60, 106))),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          load = true;
                        });
                        oldUser = await RegisterFunction.register(
                          _email.text,
                          _password.text,
                          _username.text,
                          _name.text,
                          userImage,
                          extension,
                          context,
                        );
                        setState(() {
                          load = false;
                        });
                      }
                    },
                    child: load
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Please wait'),
                              SizedBox(
                                width: 15,
                              ),
                              CustomIndigator()
                            ],
                          )
                        : Text(
                            'Register',
                            style: GoogleFonts.poppins(fontSize: 18),
                          )),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Already have account?',
                  style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 157, 156, 156)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
                  },
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ])
            ],
          ),
        )
      ],
    ));
  }
}
