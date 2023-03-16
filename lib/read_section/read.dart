import 'package:flutter/material.dart';
import 'package:read_me/fuctions/functions.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../model/model_story.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({super.key, required this.story, required this.isFavorite});
  final Story story;
  final bool isFavorite;
  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  @override
  bool dark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Variables.mColor,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                dark = !dark;
              });
            },
            child: Icon(
              dark ? Icons.dark_mode : Icons.dark_mode_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              widget.isFavorite
                  ? ClassFunctions.deleteFavorite(widget.story.id!)
                  : ClassFunctions.addFavorite(widget.story);
              setState(() {});
            },
            child: Icon(
              widget.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [Expanded(child: SfPdfViewer.network(widget.story.story,),),],
      ),
    );
  }
}
