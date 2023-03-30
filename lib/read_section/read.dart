import 'package:flutter/material.dart';
import 'package:read_me/functions/functions.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../model/model_story.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({super.key, required this.story});
  final Story story;
  
  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Variables.mColor,
        title: Text(widget.story.storyname,style: Variables.mStyle,overflow: TextOverflow.ellipsis,),
        actions: [
         
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
            
                   ClassFunctions.addFavorite(widget.story,context);
              setState(() {});
            },
            child: Icon(
              widget.story.isFavorite ? Icons.favorite : Icons.favorite_border,
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
