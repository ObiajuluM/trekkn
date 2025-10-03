import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';

// //can use to make sms and call https://pub.dev/packages/url_launcher

// /// Opens the video URL
// Future<void> openVideo(String videoUrl) async {
//   final Uri url = Uri.parse(videoUrl);
//   if (!await launchUrl(url)) {
//     log('Could not launch $url');
//   }
// }

// /// Makes a phone call to the provided phone number
// Future<void> makePhoneCall({String? phoneNumber}) async {
//   final Uri launchUri = Uri(
//     scheme: 'tel',
//     path: phoneNumber,
//   );
//   if (!await launchUrl(launchUri)) {
//     log('Could not call $launchUri');
//   }
// }

Future<void> openUrl(String url) async {
  final Uri uri = Uri.parse(url);
  try {
    await launchUrl(uri);
  } catch (e) {
    log(e.toString());
  }
}
