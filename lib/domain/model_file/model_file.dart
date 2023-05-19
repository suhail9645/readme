
import 'package:hive_flutter/hive_flutter.dart';
part 'model_file.g.dart';

@HiveType(typeId: 3)
class FileCollection {
 
  @HiveField(0)
  final String pdfName;
   @HiveField(1)
   final String pdf;
      @HiveField(2)
    final String dateTime;
        @HiveField(3)
        int? id;
  FileCollection(this.pdfName, this.pdf, this.dateTime);
}

