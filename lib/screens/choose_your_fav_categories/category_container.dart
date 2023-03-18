import 'package:flutter/material.dart';

// class InterestsContainer extends StatefulWidget {
//   const InterestsContainer({super.key, required this.text});
//   final String? text;

//   @override
//   State<InterestsContainer> createState() => _InterestsContainerState();
// }

// class _InterestsContainerState extends State<InterestsContainer> {
//   Color color = Colors.grey;
//   List favoritesSelected = [];
//   Color bColor = const Color.fromARGB(255, 59, 56, 221);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: ClipOval(
//         child: AnimatedContainer(
//           height: 85,
//           width: 25,
//           duration: const Duration(seconds: 0),
//           child: Material(
//             color: color,
//             child: InkWell(
//               child: Center(
//                 child: Text(
//                   widget.text!,
//                   style: const TextStyle(
//                     color: Color.fromARGB(255, 21, 21, 21),
//                     fontSize: 18,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//               onTap: () {
//                 setState(
//                   () {
//                     color == Colors.grey ? color = bColor : color = Colors.grey;
//                   },
//                 );
//                 // if (color == bColor) {
//                 //   favoritesSelected.add(widget.text);
//                 //   print(favoritesSelected);
//                 // } else {
//                 //   favoritesSelected.remove(widget.text);
//                 //   print(favoritesSelected);
//                 // }
                
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final List<String> categories = [
    'Music',
    'Food & Drink',
    'Sports',
    'Charity & Causes',
  ];

  final selectedHolidayTypes = <String>{};
  Color color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      mainAxisSpacing: MediaQuery.of(context).size.height * 0.03,
      crossAxisCount: 3,
      crossAxisSpacing: MediaQuery.of(context).size.width * 0.08,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        ...categories.map(
          (e) => ClipOval(
            child: AnimatedContainer(
              color: color,
              duration: const Duration(milliseconds: 100),
              padding: EdgeInsets.zero,
              child: InkWell(
                onTap: () {
                  setState(
                    () {
                      if (selectedHolidayTypes.contains(e)) {
                        // If the interest is already on the list, remove it
                        selectedHolidayTypes.remove(e);
                      } else {
                        // Otherwise, add it
                        selectedHolidayTypes.add(e);
                      }
                    },
                  );
                },
                child: Center(
                  child: Text(
                    e,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}