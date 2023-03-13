import 'package:flutter/material.dart';
import 'package:read_me/widgets/widgets.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar:const MyAppBar(),
        // body: SfPdfViewer.network(widget.story.story),
        body: CustomScrollView(slivers: [
   const  SliverAppBar(
        title: Text("My Awesome App"),
        expandedHeight: 150, //the expanded height of the app bar
      ),
      SliverList(delegate: SliverChildBuilderDelegate((context, index) => SfPdfViewer.network(widget.story.story),childCount: 1),)
      
    ]));
  }
}
