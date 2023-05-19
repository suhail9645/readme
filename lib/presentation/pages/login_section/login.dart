import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:read_me/main.dart';
import '../../../data/functions/functions.dart';
import '../home_section/home.dart';
import '../home_section/variables.dart';
import '../register_section/register.dart';
import '../widgets/widgets.dart';
import 'bloc/login_bloc.dart';

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
  late StreamSubscription subscription;
  var isDeviceConnected = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  void getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected) {
        showDialogBox();
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

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
          color: const Color.fromARGB(206, 13, 13, 15),
        ),
        Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(
                height: height / 4,
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
                child: BlocConsumer<LoginBloc, LoginState>(
                  bloc: loginBloc,
                  listener: (context, state) {
                    if (state is NavigateIntoHomePageState) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const FirstHome(),
                          ),
                          (route) => false);
                    } else if (state is LoginError) {
                      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                          contentText: state.error));
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Variables.mColor)),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              load = true;
                            });
                            // await ClassFunctions.login(
                            //   _email.text,
                            //   _password.text,
                            //   context,
                            // );
                            loginBloc.add(LoginButtonClickedEvent(
                                email: _email.text, password: _password.text));
                            setState(() {
                              load = false;
                            });
                          }
                        },
                        child: load
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                              ));
                  },
                ),
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

  void showDialogBox() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Variables.appBackground,
              actionsAlignment: MainAxisAlignment.center,
              title: Lottie.asset('assets/animations/no_internet.json',
                  height: 100, width: 100),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Internet',
                    style: Variables.mStyle,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Variables.mColor)),
                    onPressed: () async {
                      isDeviceConnected =
                          await InternetConnectionChecker().hasConnection;
                      if (isDeviceConnected) {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Try again'))
              ],
            ));
  }
}
