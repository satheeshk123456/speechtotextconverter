import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Open Excel File')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              String? filePath = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: [
                    'xls',
                    'xlsx'
                  ]).then((value) => value!.files.single.path);
              OpenFile.open(filePath!);
            },
            child: Text('Select Excel File'),
          ),
        ),
      ),
    );
  }
}
