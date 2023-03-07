import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_me/fuctions/functions.dart';
import 'package:read_me/login_section/login.dart';
import 'package:read_me/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();

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
                height: 120,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 10, 5, 0),
                    child: Text(
                      'Enter Username',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                    child: TextFormField(
                      controller: _username,
                      decoration: const InputDecoration(
                          hintText: 'eg:mspk123',
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
                        } else if (value.length < 6) {
                          return 'Password must need 6 characters';
                        } else {
                          return null;
                        }
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
                            Color.fromARGB(255, 9, 60, 106))),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          load = true;
                        });
                        await ClassFunctions.register(
                            _email.text, _password.text,_username.text, context,);
                        setState(() {
                          load = false;
                        });
                      }
                    },
                    child: load
                        ?const CustomIndigator()
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
                        builder: (context) => LoginPage(),
                      ));
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ))
              ])
            ],
          ),
        )
      ],
    ));
  }
}
