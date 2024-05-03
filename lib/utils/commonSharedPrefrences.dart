// // ignore_for_file: non_constant_identifier_names, camel_case_types, file_names

// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:value/source/Models/GetAllSiteList.dart';
// import 'package:value/source/Models/get_all_circle_center_deh_model.dart';
// import 'package:value/source/Models/server_type_model.dart';
// import '../source/Models/settings_data_model.dart';

// class commonSharedPrefrences {
//   void saveLocalStorage(SettingsData settingsData) async {
//     final sharedPrefrences = await SharedPreferences.getInstance();
//     sharedPrefrences.setString('settings', jsonEncode(settingsData));
//   }

//   Future<SettingsData> GetSettingsDataFromLocalStorage() async {
//     final sharedPrefrences = await SharedPreferences.getInstance();
//     if (sharedPrefrences.getString('settings') == null) {
//       return SettingsData();
//     }
//     Map<String, dynamic> settingsDatain =
//         jsonDecode(sharedPrefrences.getString('settings')!)
//             as Map<String, dynamic>;
//     return SettingsData.fromJson(settingsDatain);
//   }

//   // void saveAdminLocalStorage(AdminSettingsData settingsData) async {
//   //   final sharedPrefrences = await SharedPreferences.getInstance();
//   //   sharedPrefrences.setString('adminSettings', jsonEncode(settingsData));
//   // }

//   // Future<AdminSettingsData> GetAdminSettingsDataFromLocalStorage() async {
//   //   final sharedPrefrences = await SharedPreferences.getInstance();
//   //   if (sharedPrefrences.getString('adminSettings') == null) {
//   //     return AdminSettingsData();
//   //   }
//   //   Map<String, dynamic> settingsDatain =
//   //       jsonDecode(sharedPrefrences.getString('adminSettings')!)
//   //           as Map<String, dynamic>;
//   //   return AdminSettingsData.fromJson(settingsDatain);
//   // }

//   // static Future<dynamic> seasonData(String type, {String? data}) async {
//   //   final sharedPrefrences = await SharedPreferences.getInstance();
//   //   if (type == "get") {
//   //     if (sharedPrefrences.getString('seasonData') == null) {
//   //       return "";
//   //     } else {
//   //       String currentSeason =
//   //           jsonDecode(sharedPrefrences.getString('seasonData')!) as String;
//   //       return currentSeason;
//   //     }
//   //   } else if (type == "set") {
//   //     sharedPrefrences.setString('seasonData', jsonEncode(data));
//   //   }
//   // }

//   // Future<void> SaveCurrentUserInfo(String userCNIC) async {
//   //   final sharedPrefrences = await SharedPreferences.getInstance();
//   // }

//   // ?New Commit Start
//   static Future saveCirclesData(
//       List<GetAllCircleCentersDehModel> circlesData) async {
//     final sharedPrefrences = await SharedPreferences.getInstance();
//     sharedPrefrences.setString('circlesList', jsonEncode(circlesData));
//   }

//   static Future GetAllCircleData() async {
//     final sharedPrefrences = await SharedPreferences.getInstance();

//     List circlesList =
//         json.decode(sharedPrefrences.getString('circlesList') ?? "[]");

//     List<GetAllCircleCentersDehModel> list =
//         List<GetAllCircleCentersDehModel>.from(
//             circlesList.map((x) => GetAllCircleCentersDehModel.fromJson(x)));

//     return list;
//   }

//   // ?New Commit End

//   static Future saveAllSite(List<GetAllSiteList> siteData) async {
//     final sharedPrefrences = await SharedPreferences.getInstance();
//     sharedPrefrences.setString('allSitesList', jsonEncode(siteData));
//   }

//   static Future GetAllSiteData() async {
//     final sharedPrefrences = await SharedPreferences.getInstance();

//     List sitesList =
//         json.decode(sharedPrefrences.getString('allSitesList') ?? "[]");

//     List<GetAllSiteList> list = List<GetAllSiteList>.from(
//         sitesList.map((x) => GetAllSiteList.fromJson(x)));

//     return list;
//   }

//   // test or production
//   static Future saveServersListData(
//       List<GetServerTypeList> serverTypesData) async {
//     final sharedPrefrences = await SharedPreferences.getInstance();
//     sharedPrefrences.setString('serverTypes', jsonEncode(serverTypesData));
//   }

//   static Future GetServersListData() async {
//     final sharedPrefrences = await SharedPreferences.getInstance();

//     List serverTypesList =
//         json.decode(sharedPrefrences.getString('serverTypes') ?? "[]");

//     List<GetServerTypeList> list = List<GetServerTypeList>.from(
//         serverTypesList.map((x) => GetServerTypeList.fromJson(x)));

//     return list;
//   }

//   // static Future<void> SaveElpData(List<String> elpData) async {
//   //   final sharedPrefrences = await SharedPreferences.getInstance();
//   //   sharedPrefrences.setStringList('elpData', elpData);
//   // }

//   // static Future<List<String>?> GetElpData() async {
//   //   final sharedPrefrences = await SharedPreferences.getInstance();
//   //   if (sharedPrefrences.getStringList('elpData') == null) {
//   //     return [];
//   //   } else {
//   //     return sharedPrefrences.getStringList('elpData');
//   //   }
//   // }

//   // void SaveCircleSave(SettingsData settingsData) async {
//   //   final sharedPrefrences = await SharedPreferences.getInstance();
//   //   sharedPrefrences.setString('settings', jsonEncode(settingsData));
//   // }

//   //////
//   ///

//   // static Future<void> SaveVehicleTypeList(List<String> vehicleTypeList) async {
//   //   final sharedPrefrences = await SharedPreferences.getInstance();
//   //   sharedPrefrences.setStringList('vehicleTypeList', vehicleTypeList);
//   // }

//   // /////////////////////////////////////////////////
//   // static Future<void> SaveDah_VillegeList(List<String> villegeList) async {
//   //   final sharedPrefrences = await SharedPreferences.getInstance();
//   //   sharedPrefrences.setStringList('dah_VillegeList', villegeList);
//   // }

//   // static Future<void> SaveDah_VillegeIdList(List<String> villegeIdList) async {
//   //   final sharedPrefrences = await SharedPreferences.getInstance();
//   //   sharedPrefrences.setStringList('dah_VillegeIdList', villegeIdList);
//   // }
//   /////////////////////////////////////////////////
//   ///
//   ///
//   ////////////////////////////////////////////////

//   // static Future<void> SaveVarietyList(List<String> varietyList) async {
//   //   final sharedPrefrences = await SharedPreferences.getInstance();
//   //   sharedPrefrences.setStringList('varietyList', varietyList);
//   // }

//   // static Future<void> SaveVarietyIdList(List<String> varietyIdList) async {
//   //   final sharedPrefrences = await SharedPreferences.getInstance();
//   //   sharedPrefrences.setStringList('varietyIdList', varietyIdList);
//   // }
//   /////////////////////////////////////////////////
// }
