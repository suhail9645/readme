import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:read_me/presentation/pages/file_section/read_file.dart';
import '../../../data/functions/functions.dart';
import '../../../domain/model_file/model_file.dart';
import '../home_section/variables.dart';
import '../widgets/widgets.dart';

class FilePage extends StatelessWidget {
  const FilePage({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Variables.appBackground,
      appBar: AppBar(
        backgroundColor: Variables.mColor,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Files',
                  style: Variables.mStyle,
                ),
             
                const Icon(
                  Icons.file_copy,
                  color: Colors.green,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'You can pick files from your phone',
              style: Variables.sStyle,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
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
                                 showDialog(context: context, builder: (context) =>    CustomAlert(
                                      content: 'Are you this file from readme',
                                      context: context,
                                      onPress: () {
                                        ClassFunctions.deleteFile(index);
                                        Navigator.pop(context);
                                      },
                                    ),);
                                    // ClassFunctions.deleteFile(index);
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
                            Lottie.asset('assets/animations/empty_box.json'),
                            Text(
                              'NO ITEMS',
                              style: Variables.mStyle,
                            ),
                            Text(
                              'Press the add button below to add something',
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Variables.mColor,
        onPressed: () {
          ClassFunctions.fileSelection();
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      bottomNavigationBar: const CustomBottom(),
    );
  }
}
