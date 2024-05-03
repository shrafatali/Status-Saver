import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:status_saver/components/colors.dart';

class DownloadWithURLScreen extends StatefulWidget {
  const DownloadWithURLScreen({super.key});

  @override
  State<DownloadWithURLScreen> createState() => _DownloadWithURLScreenState();
}

class _DownloadWithURLScreenState extends State<DownloadWithURLScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController urlC = TextEditingController();
  double progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Download"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              TextFormField(
                controller: urlC,
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 237, 232, 232),
                  filled: true,
                  isDense: true,
                  labelText: 'URL',
                  hintText: "Enter URL",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              LinearProgressIndicator(
                value: progress.toInt() / 100,
                color: AppColors.primaryColor,
                backgroundColor: AppColors.greyColor.withOpacity(0.5),
              ),
              Text(
                "$progress%",
                style: TextStyle(color: AppColors.blackColor),
              ),
              const SizedBox(height: 30),
              // Visibility(
              //   visible: progress > 0.0 && progress.toInt() < 100,
              //   child: Column(
              //     children: [
              //       LinearProgressIndicator(
              //         value: progress.toInt() / 100,
              //         color: AppColors.primaryColor,
              //         backgroundColor: AppColors.greyColor.withOpacity(0.5),
              //       ),
              //       const SizedBox(height: 30),
              //     ],
              //   ),
              // ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await FileDownloader.downloadFile(
                        url: urlC.text.trim(),
                        name: "THE FILE NAME AFTER DOWNLOADING", //(optional)
                        onProgress: (String? fileName, double progress1) {
                          setState(() {
                            progress = progress1;
                          });
                          print('FILE fileName HAS PROGRESS $progress');
                        },
                        onDownloadCompleted: (String path) {
                          print('FILE DOWNLOADED TO PATH: $path');
                        },
                        onDownloadError: (String error) {
                          print('DOWNLOAD ERROR: $error');
                        });
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    textStyle: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                child: Text(
                  'Download',
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
