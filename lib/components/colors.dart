import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor =
      // serverType == 1 ? const
      const Color(0xff04b354);
  // : serverType == 2
  //     ? const Color(0xff2b77a0)
  //     : Colors.amber;

  static Color primaryColorTest =
      // serverType == 1 ? const Color(0xff04b354)
      // : serverType == 2
      // ?
      const Color(0xff2b77a0);
  // : Colors.amber;

  // Color.fromARGB(255, 66, 56, 142);
  static Color primaryColor08 = AppColors.primaryColor.withOpacity(.08);
  static Color amberColor = Colors.amber;
  static Color blackColor = Colors.black;
  static Color blackColor54 = Colors.black54;
  static Color whiteColor = Colors.white;
  static Color redColor = Colors.red;
  static Color greenColor = Colors.green;
  static Color greyColor = Colors.grey;
  static Color pagesColor = const Color.fromRGBO(235, 235, 235, 1);
}

// class ThemeClass {
//   static Color primaryColor =
//       serverType == 1 ? const Color(0xff04b354) : const Color(0xff2b77a0);
// }


// bankno bankbranch  accountNo