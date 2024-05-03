// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class GetStatusProvider extends ChangeNotifier {
  final List<File> _imageF = [];
  final List<File> _videoF = [];
  final List<Future<Uint8List?>> _videoTF = [];

  bool _isWhatsAppAvailable = false;

  List<File> get imageFiles => _imageF;
  List<File> get videoFiles => _videoF;
  List<Future<Uint8List?>> get videoTFiles => _videoTF;

  bool get isWhatsAppAvailable => _isWhatsAppAvailable;

  // void getStatus() async {
  //   final status = await Permission.storage.request();
  //   // Directory? directory = await getExternalStorageDirectory();

  //   if (status.isGranted) {
  //     final directory = Directory(AppConstant.whatsAppPath);
  //     print(directory);

  //     if (directory.existsSync()) {
  //       final items = directory.listSync();
  //       print("Items : ${items.toString()}");
  //     } else {
  //       print("NO WhatsApp Found. Please Install it");
  //     }
  //   } else if (status.isDenied) {
  //     Permission.storage.request();
  //     print("isDenied");
  //   }
  // }

  Future<void> checkPermissions(BuildContext context) async {
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
    if (build.version.sdkInt > 29) {
      var permission = await Permission.manageExternalStorage.request();
      if (permission.isGranted) {
        await getStatuses(context);
      } else if (permission.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Manage External Storage not granted'),
          ),
        );
      }
    } else {
      var permission = await Permission.storage.request();
      if (permission.isGranted) {
        await getStatuses(context);
      } else if (permission.isDenied) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Storage not granted')));
      }
    }
  }

  Future<void> getStatuses(BuildContext context) async {
    checkPermissions(context);

    // List<File> images = [];
    // List<File> videos = [];
    try {
      String statusDirPath =
          '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/'; // for android 11 and 11 +
      String statusDirPath2 =
          '/storage/emulated/0/WhatsApp/Media/.Statuses/'; // for android 10 and below 10

      Directory statusDir = Directory(statusDirPath);
      if (!await statusDir.exists()) {
        statusDir = Directory(statusDirPath2);
        if (await statusDir.exists()) {
          // Get list of status files
          List<FileSystemEntity> statusFiles =
              Directory(statusDir.path).listSync();
          _imageF.clear();
          _videoF.clear();

          // Check file type and add to corresponding lists
          for (FileSystemEntity file in statusFiles) {
            if (file is File) {
              if (_isImage(file.path)) {
                _imageF.add(file);
              } else if (_isVideo(file.path)) {
                _videoF.add(file);
                _videoTF.add(generateThumbnail(file));
              }
            }
          }
        }
      } else {
        // Get list of status files
        List<FileSystemEntity> statusFiles =
            Directory(statusDir.path).listSync();

        // Check file type and add to corresponding lists
        print("LIST : $statusFiles");
        _imageF.clear();
        _videoF.clear();
        for (FileSystemEntity file in statusFiles) {
          if (file is File) {
            if (_isImage(file.path)) {
              _imageF.add(file);
            } else if (_isVideo(file.path)) {
              _videoF.add(file);
              _videoTF.add(generateThumbnail(file));
            }
          }
        }
      }
      _isWhatsAppAvailable = true;
      notifyListeners();
    } catch (e) {
      // ScaffoldMessenger.of(context).clearSnackBars();
      _isWhatsAppAvailable = false;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      throw Exception(e.toString());
    }
    // setState(() {
    //   imageFiles = images;
    //   videoFiles = videos;
    // });

    // print("VIDEO : $videoFiles");

    notifyListeners();
  }

  bool _isImage(String path) {
    String extension = path.split('.').last.toLowerCase();
    return extension == 'jpg' || extension == 'jpeg' || extension == 'png';
  }

  bool _isVideo(String path) {
    String extension = path.split('.').last.toLowerCase();
    return extension == 'mp4' || extension == 'avi' || extension == 'mov';
  }

  Future<Uint8List?> generateThumbnail(File file) {
    return VideoThumbnail.thumbnailData(
      video: file.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 200,
      quality: 25,
    );
  }
}
