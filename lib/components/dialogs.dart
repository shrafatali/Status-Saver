// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:value/Components/colors.dart';
// import 'package:value/Screens/auth/Login_Screen.dart';
// import 'package:value/main.dart';

// class AppDialoges {
//   static openDialogNavigationForOutOfRange(BuildContext context,
//       String postName, double distanceInMetr, String confirmButtonText) {
//     Get.defaultDialog(
//       title: 'Out Of Range',
//       middleText: "FROM: ${postName.toUpperCase()}",
//       contentPadding: const EdgeInsets.all(20),
//       titlePadding: const EdgeInsets.only(top: 20),
//       barrierDismissible: false,
//       textConfirm: confirmButtonText.toString(),
//       confirmTextColor: Colors.white,
//       onWillPop: () async {
//         return false;
//       },
//       // confirm:
//       backgroundColor: Colors.white,
//       // onCancel:
//       onConfirm: () async {
//         sharedPrefrences!.setStringList('elpData', []);
//         sharedPrefrences!.setStringList('ccpData', []);
//         sharedPrefrences!.setStringList('tokenData', []);

//         Get.offAll(() => const LoginScreen(),
//             duration: const Duration(seconds: 3),
//             transition: Transition.leftToRight);
//       },
//     );
//   }

//   static openDialogAfterSaveORError(String? title, String? middleText,
//       String? confirmButtonText, Function()? onConfirm) {
//     Get.defaultDialog(
//       title: title ?? "",
//       middleText: middleText ?? "",
//       titleStyle: TextStyle(
//         color: title.toString() == "Success"
//             ? AppColors.greenColor
//             : AppColors.redColor,
//       ),
//       contentPadding: const EdgeInsets.all(20),

//       titlePadding: const EdgeInsets.only(top: 20),
//       barrierDismissible: false,
//       textConfirm: confirmButtonText.toString(),
//       confirmTextColor: Colors.white,

//       buttonColor: title.toString() == "Success"
//           ? AppColors.greenColor
//           : AppColors.redColor,
//       onWillPop: () async {
//         return false;
//       },
//       // confirm: ,
//       // onCancel:
//       backgroundColor: Colors.white,
//       onConfirm: onConfirm,
//     );
//   }
// }
