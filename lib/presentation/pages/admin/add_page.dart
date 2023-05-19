import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../domain/model/model_story.dart';
import '../home_section/variables.dart';
import '../widgets/widgets.dart';
import 'add_functions.dart';


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
  File? pdfFile;
  bool isAdd = false;
  bool load = false;
  String? extensionImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Variables.mColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title:Text('Admin Page',style: Variables.mStyle,),
        actions: [
          IconButton(onPressed: () {
           CustomAwesome(context: context,content: 'Admin Page', value: 'admin',).show();
          }, icon:const Icon(Icons.logout))
        ],
      ),
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
                CustomRadio(context: context, content: 'Romance'),  
                CustomRadio(context: context, content: 'History'),
                 CustomRadio(context: context, content: 'Fitness'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 CustomRadio(context: context, content: 'Horror'),
               CustomRadio(context: context, content: 'Other'),
                CustomRadio(context: context, content: 'Thriller'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 CustomRadio(context: context, content: 'Motivation'),
                CustomRadio(context: context, content: 'Adventure'),
                 CustomRadio(context: context, content: 'Top 10'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRadio(context: context, content: 'Trending now'),
                 CustomRadio(context: context, content: 'Newly published'),
                CustomRadio(context: context, content: 'Best seller'),
              ],
            ),
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
                        image = null;
                        _authorname.clear();
                        _story.clear();
                        _storyname.clear();
                        grpval = 'Romance';
                        path1 = '';
                      });
                    } else {
                      setState(() {
                        isAdd = true;
                      });
                    }
                  },
                  child: load
                      ?const Row(
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
    final ref =
        FirebaseStorage.instance.ref().child('${_storyname.text}/file.pdf');
    await ref.putFile(pdfFile!);
    final ref1 = FirebaseStorage.instance
        .ref()
        .child('${_storyname.text}/image.$extensionImage');
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
        setState(() {
          pdfFile = File(result.files.first.path!);

          path1 = result.files.first.path!;
        });
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar(contentText: 'Please add a pdf file'));
      }
    }
  }

  Future<void> addImage() async {
    var pickingimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickingimage != null) {
      setState(() {
        image = File(pickingimage.path);
        extensionImage = image!.path.split('.').last;
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
        category: AddFunctions.groupValue.value,
        firUid: 'j', isFavorite: false,);
    story.add(storydata.toJson()).whenComplete(() => ScaffoldMessenger(
        child: CustomSnackBar(contentText: 'successfully added')));
  }
}
