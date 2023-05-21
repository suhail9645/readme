import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:read_me/main.dart';
import 'package:read_me/presentation/pages/file_section/read_file.dart';
import '../../../domain/model_file/model_file.dart';
import '../home_section/variables.dart';
import '../widgets/widgets.dart';
import 'bloc/file_bloc.dart';

class FilePage extends StatelessWidget {
  const FilePage({super.key});

  @override
  Widget build(BuildContext context) {
    fileBloc.add(FileInitialEvent());
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
        child: BlocBuilder<FileBloc, FileState>(
          builder: (context, state) {
          final successState=state as FileInitial;
            return FutureBuilder(
              future: Hive.openBox<FileCollection>('files'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final fileDb = Hive.box<FileCollection>('files');

                  return ValueListenableBuilder(
                    valueListenable: fileDb.listenable(),
                    builder: (context, value, child) {
                      return successState.allFiles.isNotEmpty
                          ? ListView.builder(
                              itemCount: successState.allFiles.length,
                              itemBuilder: (context, index) {
                                List<FileCollection> files = [];
                                for (var element in value.values) {
                                  files.add(element);
                                }

                                return ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          FileRead(file: successState.allFiles[index]),
                                    ));
                                  },
                                  visualDensity: VisualDensity.compact,
                                  leading: const Icon(
                                    Icons.file_copy,
                                    color: Colors.green,
                                  ),
                                  title: Text(
                                    successState.allFiles[index].pdfName,
                                    overflow: TextOverflow.ellipsis,
                                    style: Variables.mStyle,
                                  ),
                                  subtitle: Text(
                                    successState.allFiles[index].dateTime,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => CustomAlert(
                                            content: 'Are you Sure',
                                            context: context,
                                            onPress: () {
                                              fileBloc.add(FileRemoveEvent(index: index));
                                              
                                              Navigator.pop(context);
                                            },
                                          ),
                                        );
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
                                Lottie.asset(
                                    'assets/animations/empty_box.json'),
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
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Variables.mColor,
        onPressed: () {
          fileBloc.add(FileAddEvent());
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
