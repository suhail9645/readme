import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../data/functions/functions.dart';
import '../../../domain/model_file/model_file.dart';
import '../file_section/read_file.dart'; 
import '../home_section/variables.dart';


class FileList extends StatelessWidget {
  const FileList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox<FileCollection>('files'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final fileDb = Hive.box<FileCollection>('files');

          return ValueListenableBuilder(
            valueListenable: fileDb.listenable(),
            builder: (context, value, child) {
              return value.isNotEmpty
                  ? ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        List<FileCollection> files = [];
                        for (var element in value.values) {
                          files.add(element);
                        }

                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  FileRead(file: files[index]),
                            ));
                          },
                          visualDensity: VisualDensity.compact,
                          leading: const Icon(
                            Icons.file_copy,
                            color: Colors.green,
                          ),
                          title: Text(
                            files[index].pdfName,
                            overflow: TextOverflow.ellipsis,
                            style: Variables.mStyle,
                          ),
                          subtitle: Text(
                            files[index].dateTime,
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
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
