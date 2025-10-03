// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:walkit/global/components/typewriter.dart';
// import 'package:walkit/pages/permissions/step.dart';

// class LocationPermissionPage extends ConsumerStatefulWidget {
//   const LocationPermissionPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _LocationPermissionPageState();
// }

// class _LocationPermissionPageState
//     extends ConsumerState<LocationPermissionPage> {
//   bool doneCapping = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

//       ///
//       appBar: AppBar(
//         actionsPadding: EdgeInsets.all(8),
//         title: Text(
//           "Location",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           Image.asset(
//             "assets/icons/location.png", //<a href="https://www.flaticon.com/free-icons/pin" title="pin icons">Pin icons created by Freepik - Flaticon</a>
//             height: 24,
//             width: 24,
//           ),
//         ],
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(12),
//         children: [
//           ///
//           TypewriterText(
//             text:
//                 "I'd like to use your location to give you a better experience!",
//             style: TextStyle(fontSize: 24),
//           ),

//           ///
//           TypewriterText(
//             text:
//                 '\nYour location provides accurate personalization, it is private and never shared.',
//             style: TextStyle(
//                 color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
//                 fontSize: 24),
//             onComplete: () {
//               setState(() {
//                 doneCapping = true;
//               });
//             },
//           ),
//         ],
//       ),

//       ///
//       floatingActionButton: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: doneCapping == true
//               ? null
//               : Theme.of(context).colorScheme.inverseSurface,
//           padding: const EdgeInsets.symmetric(
//             horizontal: 70,
//             vertical: 16,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(36),
//           ),
//         ),
//         onPressed: doneCapping == true
//             ? () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => StepPermissionPage()));
//               }
//             : null,
//         child: const Text(
//           "Absolutely!",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
