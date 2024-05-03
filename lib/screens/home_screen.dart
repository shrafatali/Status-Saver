// ignore_for_file: use_build_context_synchronously, must_be_immutable, avoid_print

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:status_saver/components/colors.dart';
import 'package:status_saver/screens/download_with_url.dart';
import 'package:status_saver/screens/save_screen.dart';
import 'package:status_saver/screens/view.dart';
import 'package:status_saver/utils/helper.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      ImageViewScreen(index: 1),
      ImageViewScreen(index: 2),
      SavedViewScreen(index: 3),
      const DownloadWithURLScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.photo),
        title: ("Photo"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.video_collection),
        title: ("Video"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bookmark_outlined),
        title: ("Saved"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.download),
        title: ("Download"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      // hideNavigationBar: true,
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.grey.withOpacity(0.05),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}

class ImageViewScreen extends StatefulWidget {
  int? index;
  ImageViewScreen({required this.index, super.key});

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  // bool isFachedData = false;

  bool isLoading = false;
  List<File> imageList = [];
  List<File> videoList = [];

  @override
  void initState() {
    super.initState();

    checkPermissions();
  }

  Future<void> checkPermissions() async {
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
    if (build.version.sdkInt > 29) {
      var permission = await Permission.manageExternalStorage.request();
      if (permission.isGranted) {
        await getStatuses();
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
        await getStatuses();
      } else if (permission.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage not granted')),
        );
      }
    }
  }

  Future<void> getStatuses() async {
    setState(() {
      isLoading = true;
    });
    List<File> images = [];
    List<File> videos = [];

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

          // Check file type and add to corresponding lists
          for (FileSystemEntity file in statusFiles) {
            if (file is File) {
              if (_isImage(file.path) && widget.index == 1) {
                images.add(file);
              } else if (_isVideo(file.path) && widget.index == 2) {
                videos.add(file);
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

        for (FileSystemEntity file in statusFiles) {
          if (file is File) {
            if (_isImage(file.path) && widget.index == 1) {
              images.add(file);
            } else if (_isVideo(file.path) && widget.index == 2) {
              videos.add(file);
            }
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    imageList.clear();
    videoList.clear();

    setState(() {
      imageList = images;
      videoList = videos;
      isLoading = false;
    });
  }

  bool _isImage(String path) {
    String extension = path.split('.').last.toLowerCase();
    print("extension : $extension");
    return extension == 'jpg'; // || extension == 'jpeg' || extension == 'png';
  }

  bool _isVideo(String path) {
    String extension = path.split('.').last.toLowerCase();
    return extension == 'mp4' || extension == 'avi' || extension == 'mov';
  }

  // Future<Uint8List?> generateThumbnail(File file) {
  //   return VideoThumbnail.thumbnailData(
  //     video: file.path,
  //     imageFormat: ImageFormat.JPEG,
  //     maxWidth: 200,
  //     quality: 25,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.index == 1
          ? Container(
              padding: const EdgeInsets.all(10),
              child: isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : imageList.isNotEmpty && isLoading == false
                      ? GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8),
                          children: List.generate(
                            imageList.length,
                            (index) => showContainer(
                              context,
                              imageList[index].path.toString(),
                              imageList[index].path.toString(),
                              widget.index!,
                            ),
                          ),
                        )
                      : const Center(
                          child: Text("Data not found."),
                        ),
            )
          : widget.index == 2
              ? Container(
                  padding: const EdgeInsets.all(10),
                  child: videoList.isEmpty // isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : videoList.isNotEmpty && isLoading == false
                          ? GridView(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8),
                              children:
                                  List.generate(videoList.length, (index) {
                                return FutureBuilder<String>(
                                    future: getThumbnil(
                                        videoList[index].path.toString()),
                                    builder: (context, snapshot) {
                                      return snapshot.hasData
                                          ? showContainer(
                                              context,
                                              snapshot.data.toString(),
                                              videoList[index].path.toString(),
                                              widget.index!,
                                            )
                                          : Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.primaryColor,
                                              ),
                                            );
                                    });
                              }),
                            )
                          : const Center(
                              child: Text("Data not found"),
                            ),
                )
              : const Center(child: Text("inext 3")),
    );
  }
}

Widget showContainer(
    BuildContext context, String? thumbnailPath, String? path, int index) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ViewScreen(path: path!)));
    },
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor08,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            fit: BoxFit.cover, image: FileImage(File(thumbnailPath!))),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 35,
          decoration: BoxDecoration(
            color: AppColors.redColor.withOpacity(0.2),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () async {
                  shareData(path!);
                },
                icon: Icon(
                  Icons.share,
                  color: AppColors.whiteColor,
                ),
              ),
              IconButton(
                onPressed: () async {
                  saveData(context, path!, index);
                },
                icon: Icon(
                  Icons.download,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

saveData(BuildContext context, String path, int index) async {
  try {
    // String savePath = dataType == 1 ? "" : ""
    await SaverGallery.saveFile(
      file: path,
      name: "${DateTime.now().millisecondsSinceEpoch}",
      androidRelativePath: "Android/media/com.statusSaver.app/SS Download",
      androidExistNotSave: false,
    ).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('${index == 1 ? "Image" : "Video"} Save Successfully')));
    });
  } catch (e) {
    print(e);
  }
}

shareData(String path) async {
  await FlutterNativeApi.shareImage(path);
}
