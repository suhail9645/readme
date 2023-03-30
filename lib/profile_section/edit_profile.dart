import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:read_me/model_user.dart/model_user.dart';
import 'package:read_me/profile_section/custom.dart';
import 'package:read_me/profile_section/profile_functions.dart';
import 'package:read_me/register_section/register_functions.dart';
import 'package:read_me/widgets/widgets.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key, required this.user});
  final UserData user;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  File? userImage;
  String? extension;
  String? oldUser;
  bool isButtonClicked = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Variables.appBackground,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Variables.mColor,
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: Variables.mStyle,
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: 80,
                color: Variables.mColor,
                width: double.infinity,
              ),
              Form(
                key: formKey,
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
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
                                      userImage =
                                          await RegisterFunction.imagePicking(
                                              ImageSource.gallery);
                                      if (userImage != null) {
                                        extension =
                                            userImage!.path.split('.').last;
                                      }
                                      setState(() {
                                        userImage = userImage;
                                      });
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                    },
                                    child: SizedBox(
                                      width: 120,
                                      child: Row(
                                        children: const [
                                          Text(
                                            'From Gallery',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Icon(Icons.photo, color: Colors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () async {
                                      userImage =
                                          await RegisterFunction.imagePicking(
                                              ImageSource.camera);
                                      setState(() {
                                        userImage = userImage;
                                      });
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                    },
                                    child: SizedBox(
                                      width: 120,
                                      child: Row(
                                        children: const [
                                          Text(
                                            'From Camera',
                                            style:
                                                TextStyle(color: Colors.white),
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
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: CircleAvatar(
                       
                          radius: 75,
                          backgroundImage: userImage == null
                              ? NetworkImage(widget.user.imageUrl ??
                                  'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg')
                              : FileImage(File(userImage!.path))
                                  as ImageProvider,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 10, 5, 0),
                          child: Text(
                            'Change Fullname',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                          child: TextFormField(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 17),
                            controller: _name..text = widget.user.fullName,
                            decoration: CustomDecoration(hint: 'enter name'),
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
                            'Change username',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                          child: TextFormField(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 17),
                            controller: _username..text = widget.user.userName,
                            decoration:
                                CustomDecoration(hint: 'Enter username'),
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
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Variables.mColor)),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (widget.user.fullName != _name.text ||
                                  widget.user.userName != _username.text ||
                                  userImage != null) {
                                setState(() {
                                  isButtonClicked = true;
                                });
                                await ProfileFunction.updateUser(
                                    _username.text,
                                    _name.text,
                                    userImage,
                                    extension,
                                    context,
                                    widget.user);
                                setState(() {
                                  isButtonClicked = false;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                      CustomSnackBar(
                                        contentText:'No changes occured'));
                              }
                            }
                            },
                          child: isButtonClicked
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'please wait',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CustomIndigator()
                                  ],
                                )
                              : Text(
                                  'Update',
                                  style: Variables.mStyle,
                                )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
