import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../data/functions/functions.dart';
import '../../../domain/model_file/model_file.dart';
import '../file_section/read_file.dart'; 
import '../home_section/variables.dart';


class FileList extends StatelessWidget {
  const FileList({super.key,required this.allFiles});
  final List<FileCollection>allFiles;
  @override
  Widget build(BuildContext context) {
    
              return allFiles.isNotEmpty
                  ? ListView.builder(
                      itemCount: allFiles.length,
                      itemBuilder: (context, index) {
                       
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  FileRead(file: allFiles[index]),
                            ));
                          },
                          visualDensity: VisualDensity.compact,
                          leading: const Icon(
                            Icons.file_copy,
                            color: Colors.green,
                          ),
                          title: Text(
                            allFiles[index].pdfName,
                            overflow: TextOverflow.ellipsis,
                            style: Variables.mStyle,
                          ),
                          subtitle: Text(
                            allFiles[index].dateTime,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                ClassFunctions.deleteFile(index);
                              },
                              
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        );
                      },
                    )
                  : Center(
                      child: Column(children: [
                        Lottie.asset('assets/animations/68758-search.json',
                            height: 200, width: 200),
                        Text(
                          'NO ITEMS',
                          style: Variables.mStyle,
                        ),
                        Text(
                          'Go to file adding page',
                          style: Variables.sStyle,
                        )
                      ]),
                    );
            }
          
  }
