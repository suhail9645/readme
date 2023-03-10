import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:read_me/fuctions/functions.dart';
import 'package:read_me/home_section/variables.dart';

import 'package:read_me/register_section/register.dart';

import 'package:read_me/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'assets/download_1.jfif',
          width: double.infinity,
          height: 240,
          fit: BoxFit.cover,
        ),
        Padding(
            padding: const EdgeInsets.only(top: 240),
            child: Image.asset(
              'assets/download_2.jfif',
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
            )),
        Padding(
            padding: const EdgeInsets.only(top: 475),
            child: Image.asset(
              'assets/download_3.jfif',
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
            )),
        Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(197, 13, 13, 15),
        ),
        Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 130,
              ),
              Center(
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 235, 236, 244),
                      fontSize: 28,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Center(
                child: Text(
                  'Login to your account',
                  style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 235, 236, 244),
                      fontSize: 20),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 10, 5, 0),
                    child: Text(
                      'Enter Email',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                    child: TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(
                          hintText: 'eg:abcd@gmail.com',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 9, 60, 106),
                                  width: 2)),
                          contentPadding: EdgeInsets.all(10),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 10, 5, 0),
                    child: Text(
                      'Enter Password',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                    child: TextFormField(
                      controller: _password,
                      decoration: const InputDecoration(
                          hintText: 'eg:123456',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 9, 60, 106),
                                  width: 2)),
                          contentPadding: EdgeInsets.all(10),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 20, 14, 0),
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Variables.mColor)),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          load = true;
                        });
                        await ClassFunctions.login(
                            _email.text, _password.text, context,);
                        setState(() {
                          load = false;
                        });
                      }
                    },
                    child: load
                        ?Row(
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
                            'Login',
                            style: GoogleFonts.poppins(fontSize: 18),
                          )),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Don't have account?",
                  style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 157, 156, 156)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ));
                  },
                  child: Text(
                    'Create now',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ]),
              
            ],
          ),
        )
      ],
    ));
  }
}
