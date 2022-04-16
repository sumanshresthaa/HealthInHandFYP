
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../Textstyle/constraints.dart';
class PdfApi {

  static Future<File> generateCenteredText(String text)async{
    final pdf = Document();
    final font = await rootBundle.load("fonts/nutinosans_regular.ttf");
    final ttf = Font.ttf(font);
    pdf.addPage(Page(
      //  pageFormat: PdfPageFormat.a4,
        build: (Context context){
          return Center(
            child: Text('$text', style: TextStyle(
           font: ttf
          )
          ));
        }
    ));
    return saveDocument(name: 'my_appointment.pdf', pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async{
    final byte = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(byte);
    return file;
  }

  static Future<void> openFile(File pdfFile) async {
 final url = pdfFile.path;
 await OpenFile.open(url);
  }




}
