// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:status_saver/components/colors.dart';

class ViewScreen extends StatefulWidget {
  String path;
  ViewScreen({required this.path, super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: FileImage(
                    File(widget.path.toString()),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 60,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.amberColor,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text("Banner / Native Ads"),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.greyColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () async {
                // final directory =
                //     // await getApplicationDocumentsDirectory();
                //     await getDownloadsDirectory();
                // final image = File(
                //     '${directory!.path}/Shared_picture.png');
                // image.writeAsBytesSync(bytes);
                // Share.shareFiles(
                //   [imageList[index].path],
                // );
              },
              icon: Icon(
                Icons.share,
                color: AppColors.whiteColor,
              ),
            ),
            IconButton(
              onPressed: () async {
                await ImageGallerySaver.saveFile(widget.path).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Image Save Successfully')));
                });
              },
              icon: Icon(
                Icons.download,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
