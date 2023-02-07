import 'dart:io';

import '/page/trimmer_view.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Video Trimmer'),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text('LOAD VIDEO'),
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.video,
                allowCompression: false,
              );
              if (result != null) {
                final file = File(result.files.single.path!);
                if (!mounted) return;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TrimmerView(file),
                  ),
                );
              }
            },
          ),
        ),
      );
}
