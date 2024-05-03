import 'package:video_thumbnail/video_thumbnail.dart';

// class Helper {
Future<String> getThumbnil(String pathh) async {
  String? path = await VideoThumbnail.thumbnailFile(video: pathh);
  return path!;
}
// }
