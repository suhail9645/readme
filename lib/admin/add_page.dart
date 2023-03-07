import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:read_me/model/model_user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:read_me/widgets/widgets.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _storyname = TextEditingController();

  final TextEditingController _authorname = TextEditingController();

  final TextEditingController _story = TextEditingController();
  String grpval = 'Romance';
  final _formKey = GlobalKey<FormState>();
  String? fileurl;
  String? imageurl;
  String path1 = '';
  File? image;
  PlatformFile? pickedfile;
  bool isAdd = false;
  bool load = false;
  var story;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(110, 20, 110, 20),
              child: Container(
                height: 100,
                decoration: BoxDecoration(border: Border.all()),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isAdd = false;
                    });
                    addImage();
                  },
                  child: ClipRRect(
                    child: image != null
                        ? Image.file(
                            File(image!.path),
                            height: 80,
                          )
                        : Image.asset(
                            'assets/add_image.png',
                            height: 80,
                            width: 80,
                          ),
                  ),
                ),
              ),
            ),
            Visibility(
                visible: isAdd,
                child: const Padding(
                  padding: EdgeInsets.only(left: 110),
                  child: Text(
                    'please add image',
                    style: TextStyle(color: Colors.red, fontSize: 17),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: _storyname,
                decoration: const InputDecoration(
                    hintText: 'story name', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: 'author name', border: OutlineInputBorder()),
                controller: _authorname,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: 'story pdf', border: OutlineInputBorder()),
                controller: _story..text = path1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
                onTap: () {
                  addfile();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    horizontalTitleGap: 1,
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text('Romance'),
                    leading: Radio(
                      value: 'Romance',
                      groupValue: grpval,
                      onChanged: (value) {
                        setState(() {
                          // actvalue=value;
                          grpval = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    horizontalTitleGap: 1,
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text('History'),
                    leading: Radio(
                      value: 'History',
                      groupValue: grpval,
                      onChanged: (value) {
                        setState(() {
                          // actvalue=value;
                          grpval = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    horizontalTitleGap: 1,
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text('Fitness'),
                    leading: Radio(
                      value: 'Fitness',
                      groupValue: grpval,
                      onChanged: (value) {
                        setState(() {
                          // actvalue=value;
                          grpval = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    horizontalTitleGap: 1,
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text('Horror'),
                    leading: Radio(
                      value: 'Horror',
                      groupValue: grpval,
                      onChanged: (value) {
                        setState(() {
                          // actvalue=value;
                          grpval = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    horizontalTitleGap: 1,
                    minLeadingWidth: 10,
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text('Short'),
                    leading: Radio(
                      value: 'Short',
                      groupValue: grpval,
                      onChanged: (value) {
                        setState(() {
                          // actvalue=value;
                          grpval = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    horizontalTitleGap: 1,
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text('Thriller'),
                    leading: Radio(
                      value: 'Thriller',
                      groupValue: grpval,
                      onChanged: (value) {
                        setState(() {
                          // actvalue=value;
                          grpval = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    horizontalTitleGap: 1,
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text(
                      'Motivation',
                      style: TextStyle(fontSize: 15),
                    ),
                    leading: Radio(
                      value: 'Motivation',
                      groupValue: grpval,
                      onChanged: (value) {
                        setState(() {
                          // actvalue=value;
                          grpval = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    horizontalTitleGap: 1,
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text(
                      'Adventure',
                      style: TextStyle(fontSize: 15),
                    ),
                    leading: Radio(
                      value: 'Adventure',
                      groupValue: grpval,
                      onChanged: (value) {
                        setState(() {
                          // actvalue=value;
                          grpval = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    horizontalTitleGap: 1,
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text('Top 10'),
                    leading: Radio(
                      value: 'Top 10',
                      groupValue: grpval,
                      onChanged: (value) {
                        setState(() {
                          // actvalue=value;
                          grpval = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    horizontalTitleGap: 1,
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text('Trending now'),
                    leading: Radio(
                      value: 'Trending now',
                      groupValue: grpval,
                      onChanged: (value) {
                        setState(() {
                          // actvalue=value;
                          grpval = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    horizontalTitleGap: 1,
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text('Newly published'),
                    leading: Radio(
                      value: 'Newly published',
                      groupValue: grpval,
                      onChanged: (value) {
                        setState(() {
                          // actvalue=value;
                          grpval = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    horizontalTitleGap: 1,
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text('Best seller'),
                    leading: Radio(
                      value: 'Best seller',
                      groupValue: grpval,
                      onChanged: (value) {
                        setState(() {
                          // actvalue=value;
                          grpval = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            //    TextFormField(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && image != null) {
                      setState(() {
                        load = true;
                      });

                      await addingToStorage();
                      setState(() {
                        load = false;
                      });
                    } else {
                      setState(() {
                        isAdd = true;
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
                      : const Text('add')),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> addingToStorage() async {
    final file = File(pickedfile!.path!);

    final ref =
        FirebaseStorage.instance.ref().child('${_storyname.text}/file.pdf');
    await ref.putFile(file);
    final ref1 =
        FirebaseStorage.instance.ref().child('${_storyname.text}/image.jpeg');
    await ref1.putFile(image!);
    fileurl = await ref.getDownloadURL();
    imageurl = await ref1.getDownloadURL();

    addToDatabase();
  }

  Future<void> addfile() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf']);

    if (result != null) { 
      String extension = result.paths[0]!.split('.').last;

      if (extension.toLowerCase() == 'pdf') {
        story = result;
        setState(() {
          pickedfile = result.files.first;
        });

        File file = File(result.files.single.path!);
        setState(() {
          path1 = file.path;
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar(contentText: 'Please add a pdf file'));
      }
    } else {
      // User canceled the picker
    }
  }

  Future<void> addImage() async {
    var pickingimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickingimage != null) {
      setState(() {
        image = File(pickingimage.path);
      });
    }
  }

  Future<void> addToDatabase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference story = firestore.collection('story');
    final storydata = Story(
        image: imageurl!,
        storyname: _storyname.text,
        authorname: _authorname.text,
        story: fileurl!,
        category: grpval);
    story.add(storydata.toJson());
  }
}
