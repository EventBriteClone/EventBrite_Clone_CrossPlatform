import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../functions/services/create_event.dart';
import '../../../functions/services/update_event.dart';
import '../../../models/basic_info_form.dart';
import '../../../providers/creator/basic_info_provider.dart';
import '../../../providers/creator/details_provider.dart';
import '../../../providers/creator/updated_event_two_provider.dart';
import '../../../providers/token_provider.dart';
import '../../../reusable_widgets/app_bar.dart';
import '../../../reusable_widgets/heading_description_widget.dart';
import '../../../reusable_widgets/heading_widget.dart';
import '../../../reusable_widgets/text_form_field.dart';
import '../basic_info/basic_info.dart';
import '../events_page/events.dart';

class AddDetails extends StatefulWidget {
  // final BasicInfoFormData? previousBasicInfoData;
  final bool? update;
  const AddDetails({super.key, required this.update});
  //this.previousBasicInfoData,

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  /// A GlobalKey [_formKey] that can be used to access the FormState for this form.
  final _formKey = GlobalKey<FormState>();

  //final TextEditingController _eventSummaryController = TextEditingController();
  // final TextEditingController _eventDescController = TextEditingController();

  /// FORM DATA:
  /// ----------
  /// ///variables to be saved from the form for later use: (3 variables)
  ///1. [_eventSummary] for the event Summary field in [TextFormFieldWidget]  a custom widget
  // String? _eventSummary;

  // ///2. [_eventDesc] for the event  Descrption in [TextFormFieldWidget]  a custom widget
  // String? _eventDesc;

  // ///3. [_eventImage] for the event image which is of type [File] , it could be uploaded from gallery or camera
  // File? _eventImage;

  // ///4. [_imagePath] to ptvde a string for the url of the iamage
  // String? _imagePath;

  /// This is a [Scaffold ] widget that consists of [appBarWidget], and [ListView] to allow the page to be scrollable
  /// It consists of 3 sections:
  ///                           * Event media section for user to upload image from gallery using [ImagePicker] and [_handleUploadImageButtonTap] method
  ///                           * Event summary
  ///                           * Event descrption

  // @override
  // void initState() {
  //   super.initState();

  //   // Add a post-frame callback to run a function after the widgets are built and rendered.
  //   WidgetsBinding.instance!.addPostFrameCallback((_) {
  //     // OUR OLDDDDDDDDDDDDDDD DATAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
  //     String eventDesc = widget.previousBasicInfoData?.eventDesc ?? '';
  //     String eventSummary = widget.previousBasicInfoData?.summary ?? '';
  //     File? eventImage = widget.previousBasicInfoData?.eventImage ?? null;

  //     print(eventDesc);
  //     print(eventSummary);
  //     print(eventImage);

  //     final prevModel =
  //         Provider.of<UpdatedEventTwoProvider>(context, listen: false);
  //     prevModel.eventDesc = eventDesc;
  //     prevModel.eventSummary = eventSummary;
  //     prevModel.eventImage = eventImage;

  //     //we need to make new data = old data then check later if they are equal or not

  //     final newmodel =
  //         Provider.of<DetailsFormDataProvider>(context, listen: false);

  //     newmodel.eventDesc = prevModel.eventDescController.text;
  //     newmodel.eventSummary = prevModel.eventSummaryController.text;
  //     newmodel.eventImage = prevModel.eventImage;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final formData = context.watch<DetailsFormDataProvider>().formData;
    String? token = Provider.of<TokenModel>(context).token;
    return Scaffold(
      appBar: const AppBarWidget(
        appBarText: 'Event Details',
      ),
      body: Consumer2<DetailsFormDataProvider, UpdatedEventTwoProvider>(
          builder: (BuildContext context, newmodel, oldmodel, Widget? child) {
        return ListView(
          shrinkWrap: true,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Section1:
                      Image.asset(
                        'assets/images/eventimage.png',
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      const HeadingWidget(
                        headingText: "Event media",
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Images',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            fontFamily: "segoe ui",
                            color: Color.fromARGB(221, 30, 30, 30),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 20),
                        child: Text(
                          'Add photos to show what your event will be about. You can upload up to 10 images.',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "segoe ui",
                            color: Color.fromARGB(221, 30, 30, 30),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(46, 232, 222, 249)),
                          child: Row(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  'assets/images/mediaex.png',
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  '82% of attendees prefer main event images that show an event\'s vibe and atmosphere.',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "segoe ui",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(46, 232, 222, 249),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(46, 232, 222, 249),
                              // blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                        child: newmodel.eventImage != null
                            ? Image.file(newmodel.eventImage!)
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FractionallySizedBox(
                                    widthFactor: 0.25,
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 40),
                                        child: Image.asset(
                                          'assets/images/eventimage.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    key: ValueKey("handleimageupload"),
                                    onPressed: _handleUploadImageButtonTap,
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(200, 60),
                                      primary: Colors.white,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 128, 127, 127),
                                            width: 2),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/uploadimage.png',
                                          height: 25,
                                          width: 25,
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          'Upload image',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "segoe ui",
                                            color:
                                                Color.fromARGB(221, 30, 30, 30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: const [
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              Icons.fiber_manual_record,
                              size: 15,
                              color: Colors.black,
                            ),
                            title: Text(
                                ' Recommended image size: 2160 x 1080px',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black)),
                            trailing: SizedBox(height: 0),
                          ),
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              Icons.fiber_manual_record,
                              size: 15,
                              color: Colors.black,
                            ),
                            title: Text('Maximum file size: 10MB',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black)),
                            trailing: SizedBox(height: 0),
                          ),
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              Icons.fiber_manual_record,
                              size: 15,
                              color: Colors.black,
                            ),
                            title: Text('Supported image files: JPEG or PNG',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black)),
                            trailing: SizedBox(height: 0),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      //Section2:
                      Image.asset(
                        'assets/images/Tevents.png',
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),

                      const HeadingWidget(
                        headingText: "Summary",
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      const HeadingDescriptionWidget(
                        headingDescText:
                            "Grab people's attention with a short description about your event. Attendees will see this at the top of your event page. (140 characters max)",
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      TextFormFieldWidget(
                        key: ValueKey("summary"),
                        TitleController: newmodel.eventSummaryController,
                        maxLength: 140,
                        // initialValue: _eventSummary,
                        hint:
                            'write a short event summary to get attendees excited.',
                        isSuffixRequired: false,
                        label: 'Summary',
                        // onChanged: (value) {
                        //   setState(() {
                        //     _eventSummary = value;
                        //   });
                        // },
                      ),

                      //Section3:
                      Image.asset(
                        'assets/images/Tevents.png',
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),

                      const HeadingWidget(
                        headingText: "Description",
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      const HeadingDescriptionWidget(
                        headingDescText:
                            "Add more details to your event like your schedule, sponsors, or featured guests",
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      TextFormFieldWidget(
                        key: ValueKey("desc"),
                        TitleController: newmodel.eventDescController,
                        maxLength: 2000,
                        // initialValue: _eventDesc,
                        maxlines: 5,
                        hint: '',
                        isSuffixRequired: false,
                        label: 'Description',
                        // onChanged: (value) {
                        //   setState(() {
                        //     _eventDesc = value;
                        //   });
                        // },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 150,
                  height: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(161, 0, 0, 0),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      key: ValueKey("eventpage"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EventPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Discard',
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 22,
                            color: Color.fromARGB(161, 0, 0, 0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      //to get from the previous page the data
                      final basicInfoData =
                          Provider.of<BasicInfoFormDataProvider>(context,
                              listen: false);

                      // final prevmodel = Provider.of<UpdatedEventTwoProvider>(
                      //     context,
                      //     listen: false);

                      Provider.of<BasicInfoFormDataProvider>(context,
                              listen: false)
                          .saveSecData(
                        newmodel.eventSummaryController.text,
                        newmodel.eventDescController.text,
                        newmodel.eventImage,
                      );

                      Provider.of<DetailsFormDataProvider>(context,
                              listen: false)
                          .saveData(
                        newmodel.eventSummaryController.text,
                        newmodel.eventDescController.text,
                        newmodel.eventImage,
                      );

                      print(newmodel.eventSummaryController.text);
                      print(basicInfoData.formData.summary);

                      if (widget.update == false) {
                        print("before create");
                        final createEventResult =
                            await CreateEventService().createEvent(
                              token: token,
                          eventTitle: basicInfoData.formData.eventTitle,
                          type: basicInfoData.formData.type,
                          category: basicInfoData.formData.category,
                          sub_Category: '',
                          organizer: basicInfoData.formData.organizer,
                          eventStart: basicInfoData.formData.eventStart,
                          startTime: basicInfoData.formData.startTime,
                          eventEnd: basicInfoData.formData.eventEnd,
                          endTime: basicInfoData.formData.endTime,
                          venueLocation: basicInfoData.formData.venueLocation,
                          online: basicInfoData.formData.online,
                          CAPACITY: null,
                          eventDesc: basicInfoData.formData.eventDesc,
                          eventImage: basicInfoData.formData.eventImage,
                          status: basicInfoData.formData.status,
                          summary: basicInfoData.formData.summary,
                        );

                        print(createEventResult['ID']);
                        final eventId = createEventResult['ID'];
                        basicInfoData.eventId = eventId;
                        // final eventModel =
                        //     Provider.of<BasicInfoFormDataProvider>(context,
                        //         listen: false);
                        // final storedEventId = eventModel.eventId;
                      } else {
                        if (oldmodel.eventDescController.text !=
                            newmodel.eventDescController.text) {
                          UpdateEventServices().updateField(
                              id: basicInfoData.eventId!,
                              fieldName: 'Description',
                              newValue: newmodel.eventDescController.text,
                              context: context);
                        }
                        if (newmodel.eventSummaryController.text !=
                            oldmodel.eventSummaryController.text) {
                          UpdateEventServices().updateField(
                              id: basicInfoData.eventId!,
                              fieldName: 'summery',
                              newValue: newmodel.eventSummaryController.text,
                              context: context);
                        }
                        if (newmodel.eventImage != oldmodel.eventImage) {}
                      }
                      // print()

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BasicInfo()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 210, 78, 42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        );
      }),
    );
  }

  Future<XFile?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    return pickedFile;
  }

  void _handleUploadImageButtonTap() async {
    final imageFile = await pickImage(ImageSource.gallery);

    final image = Provider.of<DetailsFormDataProvider>(context, listen: false);

    if (imageFile != null) {
      setState(() {
        image.eventImage = File(imageFile.path);
        image.imagePath = imageFile.path;
      });
    }
  }
}
