// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SavedViewScreen extends StatefulWidget {
  int? index;
  SavedViewScreen({required this.index, super.key});

  @override
  State<SavedViewScreen> createState() => _SavedViewScreenState();
}

class _SavedViewScreenState extends State<SavedViewScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("foo.videoFiles.length.toString()"),
      ),
    );
  }
}
