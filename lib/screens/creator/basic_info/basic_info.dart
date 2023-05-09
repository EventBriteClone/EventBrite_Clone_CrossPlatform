import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../../components/basic_info_details/event_date.dart';
import '../../../components/basic_info_details/event_tickets.dart';
import '../../../components/basic_info_details/event_title_component.dart';
import '../../../components/basic_info_details/event_type_category.dart';
import '../../../components/basic_info_details/event_venue.dart';
import '../../../components/inside_side_menu.dart';
import '../../../models/basic_info_form.dart';
import '../../../providers/creator/basic_info_provider.dart';
import '../../../providers/creator/date_selection_provider.dart';
import '../../../providers/creator/details_provider.dart';
import '../../../reusable_widgets/app_bar.dart';
import '../../../reusable_widgets/image_widget.dart';

///This [BasicInfo] [StatelessWidget] has the UI of the Basic info when user submits the form
///It includes a [Drawer] for navigation where it calls the [buildDrawer] method
///it uses 2 consumers [Consumer2] for [BasicInfoFormDataProvider] and [DetailsFormDataProvider] to retrieve the data and display it
///

class BasicInfo extends StatefulWidget {
  final BasicInfoFormData? previousBasicInfoData;
  const BasicInfo({Key? key, this.previousBasicInfoData});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: buildDrawer(context),
      ),

      appBar: AppBarWidget(
        appBarText: 'Event Details',
      ),
      // drawer: Drawer(),
      body: Consumer2<BasicInfoFormDataProvider, DetailsFormDataProvider>(
          builder:
              (BuildContext context, basicIfoData, detailsData, Widget? child) {
        final basicformData = basicIfoData.formData;
        final detailsfromData = detailsData.formData;

        basicformData.eventID ??= widget.previousBasicInfoData?.eventID;
        print(basicformData.eventID);
      //  basicIfoData.eventId = basicformData.eventID;

        basicformData.eventStart ??= widget.previousBasicInfoData?.eventStart;
        basicformData.eventEnd ??= widget.previousBasicInfoData?.eventEnd;
        basicformData.startTime ??= widget.previousBasicInfoData?.startTime;
        basicformData.endTime ??= widget.previousBasicInfoData?.endTime;
        basicformData.eventDesc ??= widget.previousBasicInfoData?.eventDesc;
        basicformData.eventImage ??= widget.previousBasicInfoData?.eventImage;
        basicformData.eventTitle ??= widget.previousBasicInfoData?.eventTitle;
        basicformData.online ??= widget.previousBasicInfoData?.online;
        basicformData.organizer ??= widget.previousBasicInfoData?.organizer;
        basicformData.status ??= widget.previousBasicInfoData?.status;
        basicformData.summary ??= widget.previousBasicInfoData?.summary;
        basicformData.type ??= widget.previousBasicInfoData?.type;
        basicformData.venueLocation ??=
            widget.previousBasicInfoData?.venueLocation;
        basicformData.category ??= widget.previousBasicInfoData?.category;

        final eventTitle = basicformData.eventTitle;
        // ??
        //     widget.previousBasicInfoData?.eventTitle;

        final type = basicformData.type;
        // ?? widget.previousBasicInfoData?.type;
        final category = basicformData.category;
        //?? widget.previousBasicInfoData?.category;
        final location = basicformData.venueLocation;
        //?? widget.previousBasicInfoData?.venueLocation;

        //final singleorRecurring = basicformData.singleOrRecurring;

        String formattedDateStart = '';
        String formattedDateEnd = '';
        String formattedStartTime = '';
        String formattedEndTime = '';

        // if (singleorRecurring == 'Single') {
        final eventStart = basicformData.eventStart;
        //??
        //   widget.previousBasicInfoData?.eventStart;
        final eventEnd = basicformData.eventEnd;
        //?? widget.previousBasicInfoData?.eventEnd;
        final startTime = basicformData.startTime;
        //?? widget.previousBasicInfoData?.startTime;
        final endTime = basicformData.endTime;
        // ?? widget.previousBasicInfoData?.endTime;
        formattedDateStart = eventStart.toString().substring(0, 10);
        formattedDateStart = DateFormat('E, d MMM yyyy').format(eventStart!);
        formattedDateEnd = eventEnd.toString().substring(0, 10);
        formattedDateEnd = DateFormat('E, d MMM yyyy').format(eventEnd!);

        formattedStartTime = DateFormat.jm()
            .format(DateTime(1, 1, 1, startTime!.hour, startTime.minute));
        formattedEndTime = DateFormat.jm()
            .format(DateTime(1, 1, 1, endTime!.hour, endTime.minute));

        final summary = basicformData.summary;
        //?? widget.previousBasicInfoData?.summary;

        final desc = basicformData.eventDesc;
        //  ?? widget.previousBasicInfoData?.eventDesc;

        File? eventImage;
        bool isUploaded = false;
        if (basicformData.eventImage == null) {
          // if (widget.previousBasicInfoData?.eventImage == null) {
          // user has not uploaded an image
          isUploaded = false;
          //} else {
          // eventImage = widget.previousBasicInfoData?.eventImage;
          // isUploaded = true;
          //  }
        } else {
          // user has uploaded an image
          eventImage = basicformData.eventImage!;
          isUploaded = true;
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              ImageWidget(
                imageUrl: eventImage,
                isUploaded: isUploaded,
              ),
              EventTitle(
                eventTitle: eventTitle!,
                formData: basicformData,
                summary: summary,
                desc: desc,
              ),
              const SizedBox(
                height: 20,
              ),
              EventDateDetails(
                  formattedDateStart: formattedDateStart,
                  formattedStartTime: formattedStartTime,
                  formattedDateEnd: formattedDateEnd,
                  formattedEndTime: formattedEndTime),
              const SizedBox(
                height: 40,
              ),
              EventVenue(location: location!),
              const SizedBox(
                height: 40,
              ),
              EventTypeCategory(type: type!, category: category!),
              const SizedBox(
                height: 40,
              ),
              const EventTickets(),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        );
      }),
    );
  }
}


/*
// @override
  // void initState() {
  //   super.initState();

  //   // Add a post-frame callback to run a function after the widgets are built and rendered.
  //   WidgetsBinding.instance!.addPostFrameCallback((_) {
  //     // OUR  DATAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
  //     String eventName = widget.previousBasicInfoData?.eventTitle ?? '';
  //     String organizer = widget.previousBasicInfoData?.organizer ?? '';
  //     String type = widget.previousBasicInfoData?.type ?? '';
  //     String category = widget.previousBasicInfoData?.category ?? '';
  //     String location = widget.previousBasicInfoData?.venueLocation ?? '';
  //     int eventID = widget.previousBasicInfoData?.eventID ?? 0;
  //     String online = widget.previousBasicInfoData?.online ?? '';
  //     String selectedLocationInput =
  //         widget.previousBasicInfoData?.venueLocation ?? '';
  //     String status = widget.previousBasicInfoData?.status ?? '';

  //     String summary = widget.previousBasicInfoData?.summary ?? '';
  //     String desc = widget.previousBasicInfoData?.eventDesc ?? '';
  //     File? image = widget.previousBasicInfoData?.eventImage ?? null;

  //     bool displayStartTimeSingle = false;
  //     bool displayEndTimeSingle = false;
  //     bool displayEndTimeRecurring = false;

      

  //     //we need to get them and make them equal to the providers

  //     final newmodel =
  //         Provider.of<BasicInfoFormDataProvider>(context, listen: false);

  //     final newmodelTwo =
  //         Provider.of<DetailsFormDataProvider>(context, listen: false);

      

  //     newmodelTwo.saveData(summary, desc, image);
  //   });
  // }
*/