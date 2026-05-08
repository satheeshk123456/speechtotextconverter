import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  // List<List<dynamic>> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Pick file and open",
              style: TextStyle(color: Colors.amber),
            ),
            centerTitle: true,
            backgroundColor: Colors.black),
        body: Container(
          alignment: Alignment.center,
          color: Colors.black,
          child: ElevatedButton(
            onPressed: () async {
              final data = await FilePicker.platform.pickFiles();
              if (data == null) return;
              final file = data.files.first;
              openFile(file);
              final newfile = await saveFilePermanently(file);
            },
            child: Icon(Icons.open_in_full),
          ),
        ));
  }

  void openFile(PlatformFile file) async {
    OpenFile.open(file.path!);
    List<List<dynamic>> list = [];
    var rawdata = await rootBundle.loadString("${file}");
    List<List<dynamic>> listdata = const CsvToListConverter().convert(rawdata);
    setState(() {
      list = listdata;
    });
    find(list);
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newfile = File('${appStorage.path}/${file.name}');
    return File(file.path!).copy(newfile.path);
  }

  void find(List<List> list) {
    ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, i) {
        print(list[i][1].toString());
      },
    );
  }
}
