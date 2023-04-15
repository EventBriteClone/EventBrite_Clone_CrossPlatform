import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'empty_image_widget.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show File, Platform;

///[ImageWidget] is a custom widget where it's responsible for loading the image uploaded by the user if it exists or displaying a default image instead
/// Its constructor takes the following:
///  * [imageUrl] which is of type [File] to represent the image uploaded by the user, if it's null then the default image is shown
///  * [isUploaded] a [bool] to help me check first if [imageUrl] is null or not
/// They are both required

class ImageWidget extends StatelessWidget {
  final File? imageUrl;
  final bool? isUploaded;

  const ImageWidget(
      {Key? key, required this.imageUrl, required this.isUploaded})
      : super(key: key);

  ///The widget returns a [Column] that has a [Stack] consisting of a ternary condition to check first if [imageUrl] is null or not
  ///Then accordingly have another ternary condition which checks first the platform whether it's on web or on mobile then displays either the [Image] from [imageUrl] inside a [Padding]
  ///Or calls the [EmptyImage] widget which is a widget that shows a default Image

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            imageUrl != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: 
                    kIsWeb
                        ? 
                        Image.network(
                            imageUrl!.path,
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.height * 1,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            imageUrl!,
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.height * 1,
                            fit: BoxFit.cover,
                          ),
                  )
                : // Default image
                const EmptyImage(),
          ],
        ),
      ],
    );
  }
}






// import 'dart:io';

// import 'package:flutter/material.dart';

// import '../constants/constants.dart';
// import 'empty_image_widget.dart';

// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart' as http;

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io' show File, Platform;

// ///[ImageWidget] is a custom widget where it's responsible for loading the image uploaded by the user if it exists or displaying a default image instead
// /// Its constructor takes the following:
// ///  * [imageUrl] which is of type [File] to represent the image uploaded by the user, if it's null then the default image is shown
// ///  * [isUploaded] a [bool] to help me check first if [imageUrl] is null or not
// /// They are both required

// class ImageWidget extends StatelessWidget {
//   final File? imageUrl;
//   final bool? isUploaded;

//   const ImageWidget(
//       {Key? key, required this.imageUrl, required this.isUploaded})
//       : super(key: key);

//   ///The widget returns a [Column] that has a [Stack] consisting of a ternary condition to check first if [imageUrl] is null or not
//   ///Then accordingly have another ternary condition which checks first the platform whether it's on web or on mobile then displays either the [Image] from [imageUrl] inside a [Padding]
//   ///Or calls the [EmptyImage] widget which is a widget that shows a default Image

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             imageUrl != null 
//             ?
                
//                    Padding(
//                         padding: const EdgeInsets.only(top: 20.0),
//                         child: Image.file(
//                           imageUrl!,
//                           height: MediaQuery.of(context).size.height * 0.3,
//                           width: MediaQuery.of(context).size.height * 1,
//                           fit: BoxFit.cover,
//                         ),
//                       )
//                 : // Default image
//                 const EmptyImage(),
//           ],
//         ),
//       ],
//     );
//   }
// }


// import 'dart:io';

// import 'package:flutter/material.dart';

// import '../constants/constants.dart';
// import 'empty_image_widget.dart';

// ///[ImageWidget] is acustom Widget where its responsible for loading the image uploaded by user if exists or displayinga default image instead
// /// It's Constructor takes the following:
// ///  * [imageUrl] which is of type [File] to represent the image uploaded by the user, if its null then default image is shown
// ///  * [isUploaded] a [bool] to help me check first if [imageUrl] is null or not
// /// They are both required

// class ImageWidget extends StatelessWidget {
//   final File? imageUrl;
//   final bool? isUploaded;

//   const ImageWidget(
//       {Key? key, required this.imageUrl, required this.isUploaded})
//       : super(key: key);

// ///The widget returns a [Column] that has a [Stack] consisting of a ternary condition to check first if [imageUrl] is null or not
// ///Then accordingly have another ternary condition which checks first the platform whether its on web or on mobile then displays either  the [Image] from [file] inside a [Padding]
// ///Or calls the [EmptyImage] widget which is a widget that shows a default Image

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             imageUrl != null
//                 ?
//         kIsWeb
//             ? Padding(
//                     padding: const EdgeInsets.only(top: 20.0),
//                     child: Image.network(
//                       imageUrl!.path,
//                       height: MediaQuery.of(context).size.height * 0.3,
//                       width: MediaQuery.of(context).size.height * 1,
//                       fit: BoxFit.cover,
//                     ),
//                   )

//             :
//             Padding(
//                     padding: const EdgeInsets.only(top: 20.0),
//                     child: Image.file(
//                       imageUrl!,
//                       height: MediaQuery.of(context).size.height * 0.3,
//                       width: MediaQuery.of(context).size.height * 1,
//                       fit: BoxFit.cover,
//                     ),
//                   )
//                 :
//                 // Default image
//                 const EmptyImage(),

//           ],
//         ),
//       ],
//     );
//   }
// }