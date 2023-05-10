// import 'package:flutter/material.dart';

// import 'info_cards.dart';

// class SideMenu extends StatefulWidget {
//   const SideMenu({super.key});

//   @override
//   State<SideMenu> createState() => _SideMenuState();
// }

// class _SideMenuState extends State<SideMenu> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           width: 288,
//           height: double.infinity,

//           ///full height of the parent widget (parent here is safe area)
//           color: const Color.fromARGB(255, 13, 5, 37),
//           child: SafeArea(
//             ///safe area is to ensure padding and space to not get overlapped with Hw
//             child: Column(
//               children: [
//                 ///we could extract this listTitle widget
//                 const InfoCard(
//                   name: "Mahinour Alaa",
//                   profession: "organizer",
//                 ),
//                 ListTile(
//                   leading: SizedBox(
//                     height: 34,
//                     width: 34,

//                     ///child: RiveAnimation.asset("assets/RiveAssets/home.riv", artboard: "HOME",
//                   ),
//                 )
//               ],
//             ),
//           )),
//     );
//   }
// }
