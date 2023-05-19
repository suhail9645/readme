import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../domain/model_file/model_file.dart';
import '../home_section/variables.dart';

class FileRead extends StatelessWidget {
  const FileRead({super.key, required this.file});
final FileCollection file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyAppBar(title: file.pdfName, subtitle: 'Added on ${file.dateTime}'),
       appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: AppBar(
          backgroundColor: Variables.mColor,
          title: Column(
            children: [
              Text(
                file.pdfName,overflow: TextOverflow.ellipsis,
                style: Variables.mStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                file.dateTime,
                style: Variables.sStyle,
              )
            ],
          ),
        ),
      ),
      body: SfPdfViewer.file(File(file.pdf)),
    );
  }
}