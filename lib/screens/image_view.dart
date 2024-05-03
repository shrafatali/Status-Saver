// ignore_for_file: must_be_immutable

// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:status_saver/components/colors.dart';
import 'package:status_saver/provider/get_status_provider.dart';

// class ImageViewScreen extends StatefulWidget {
//   int? index;
//   ImageViewScreen({required this.index, super.key});

//   @override
//   State<ImageViewScreen> createState() => _ImageViewScreenState();
// }

// class _ImageViewScreenState extends State<ImageViewScreen> {
//   bool isFachedData = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<GetStatusProvider>(
//         builder: (context, status, child) {
//           if (isFachedData == false) {
//             status.getStatuses(context);
//             isFachedData = true;
//           }
//           print("VAL : $isFachedData");
//           return status.isWhatsAppAvailable == false
//               ? const Center(
//                   child: Text("WhatsApp Not Available"),
//                 )
//               : status.imageFiles.isEmpty
//                   ? const Center(
//                       child: Text("No Images Found"),
//                     )
//                   : Container(
//                       padding: const EdgeInsets.all(10),
//                       child: GridView(
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 8,
//                                 mainAxisSpacing: 8),
//                         children: List.generate(
//                           status.imageFiles.length,
//                           (index) => Container(
//                             // height: ,
//                             decoration: BoxDecoration(
//                               color: AppColors.primaryColor,
//                               borderRadius: BorderRadius.circular(10),
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: FileImage(
//                                   File(status.imageFiles[index].path),
//                                 ),
//                               ),
//                             ),
//                             child: Align(
//                               alignment: Alignment.bottomCenter,
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 width: double.infinity,
//                                 height: 35,
//                                 decoration: BoxDecoration(
//                                   color: AppColors.redColor.withOpacity(0.2),
//                                   borderRadius: const BorderRadius.only(
//                                       bottomLeft: Radius.circular(10),
//                                       bottomRight: Radius.circular(10)),
//                                 ),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Icon(
//                                       Icons.share,
//                                       color: AppColors.whiteColor,
//                                     ),
//                                     Icon(
//                                       Icons.download,
//                                       color: AppColors.whiteColor,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//         },
//       ),
//     );
//     // },

//     //   Consumer<GetStatusProvider>(
//     //     builder: (context, status, child) {
//     //       if (isFachedData == false) {
//     //         Future.delayed(const Duration(seconds: 10)).then((value) {
//     //           isFachedData = true;
//     //           //     print("Length : ${status.videoFiles.length}");
//     //         });
//     //       }
//     //       print("Empty : ${status.imageFiles.length}");
//     // return status.isWhatsAppAvailable == false
//     //     ? const Center(
//     //         child: Text("WhatsApp Not Available"),
//     //       )
//     //     : status.videoFiles.isEmpty
//     //         ? const Center(
//     //             child: Text("No Images Found"),
//     //           )
//     //         : Container(
//     //             padding: const EdgeInsets.all(10),
//     //             child: GridView(
//     //               gridDelegate:
//     //                   const SliverGridDelegateWithFixedCrossAxisCount(
//     //                       crossAxisCount: 2,
//     //                       crossAxisSpacing: 8,
//     //                       mainAxisSpacing: 8),
//     //               children: List.generate(
//     //                 status.videoFiles.length,
//     //                 (index) => Container(
//     //                   // height: ,
//     //                   decoration: BoxDecoration(
//     //                     color: AppColors.primaryColor,
//     //                     borderRadius: BorderRadius.circular(10),
//     //                   ),
//     //                   child: Align(
//     //                     alignment: Alignment.bottomCenter,
//     //                     child: Container(
//     //                       alignment: Alignment.center,
//     //                       width: double.infinity,
//     //                       height: 35,
//     //                       decoration: BoxDecoration(
//     //                         color: AppColors.redColor.withOpacity(0.1),
//     //                         borderRadius: const BorderRadius.only(
//     //                             bottomLeft: Radius.circular(10),
//     //                             bottomRight: Radius.circular(10)),
//     //                       ),
//     //                       child: Row(
//     //                         crossAxisAlignment: CrossAxisAlignment.start,
//     //                         mainAxisAlignment:
//     //                             MainAxisAlignment.spaceEvenly,
//     //                         children: [
//     //                           Icon(
//     //                             Icons.share,
//     //                             color: AppColors.whiteColor,
//     //                           ),
//     //                           Icon(
//     //                             Icons.download,
//     //                             color: AppColors.whiteColor,
//     //                           )
//     //                         ],
//     //                       ),
//     //                     ),
//     //                   ),
//     //                 ),
//     //               ),
//     //             ),
//     //           );
//     //     },
//     // ),
//     // ),
//     // )
//   }
// }

/////////////////////////////////////////////////

class VViewScreen extends StatefulWidget {
  int? index;
  VViewScreen({required this.index, super.key});

  @override
  State<VViewScreen> createState() => _VViewScreenState();
}

class _VViewScreenState extends State<VViewScreen> {
  // late List<Future<Uint8List?>> _thumbnailFutures;

  GetStatusProvider? sProvider;

  @override
  void initState() {
    sProvider = Provider.of<GetStatusProvider>(context);
    super.initState();
  }

  bool isFachedData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            // Consumer<GetStatusProvider>(
            //   builder: (context, status, child) {
            //     if (isFachedData == false) {
            //       status.getStatuses(context);
            //       isFachedData = true;
            //     }
            //     print("VAL : $isFachedData");
            // return
            GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: sProvider!.videoTFiles.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                    future: sProvider!.videoTFiles[index],
                    builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error loading thumbnail'),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            // await saveVideo(widget.videoFiles[index]);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: snapshot.data != null
                                  ? Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.fill,
                                    )
                                  : Container(), // Placeholder if thumbnail is not available,
                            ),
                          ),
                        );
                      }
                    },
                  );
                }));
    // status.isWhatsAppAvailable == false
    //     ? const Center(
    //         child: Text("WhatsApp Not Available"),
    //       )
    //     : status.videoTFiles.isEmpty
    //         ? const Center(
    //             child: Text("No Video Found"),
    //           )
    //         : Container(
    //             padding: const EdgeInsets.all(10),
    //             child: GridView(
    //               gridDelegate:
    //                   const SliverGridDelegateWithFixedCrossAxisCount(
    //                       crossAxisCount: 2,
    //                       crossAxisSpacing: 8,
    //                       mainAxisSpacing: 8),
    //               children: List.generate(
    //                 status.videoTFiles.length,
    //                 (index) => Container(
    //                   // height: ,
    //                   decoration: BoxDecoration(
    //                     color: AppColors.primaryColor,
    //                     borderRadius: BorderRadius.circular(10),
    //                     image: DecorationImage(
    //                       fit: BoxFit.cover,
    //                       image: MemoryImage(
    //                         status.videoTFiles[index]!,
    //                       ),
    //                     ),
    //                   ),
    //                   child: Align(
    //                     alignment: Alignment.bottomCenter,
    //                     child: Container(
    //                       alignment: Alignment.center,
    //                       width: double.infinity,
    //                       height: 35,
    //                       decoration: BoxDecoration(
    //                         color: AppColors.redColor.withOpacity(0.2),
    //                         borderRadius: const BorderRadius.only(
    //                             bottomLeft: Radius.circular(10),
    //                             bottomRight: Radius.circular(10)),
    //                       ),
    //                       child: Row(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         mainAxisAlignment:
    //                             MainAxisAlignment.spaceEvenly,
    //                         children: [
    //                           Icon(
    //                             Icons.share,
    //                             color: AppColors.whiteColor,
    //                           ),
    //                           Icon(
    //                             Icons.download,
    //                             color: AppColors.whiteColor,
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           );
    // },
    // ),
    // );
  }
}
