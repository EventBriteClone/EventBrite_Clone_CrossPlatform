import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer/components/main_side_menu.dart';
import 'package:organizer/models/basic_info_form.dart';
import 'package:provider/provider.dart';

import '../../../components/basic_info_details/event_date.dart';

import '../../../components/basic_info_details/event_tickets.dart';
import '../../../components/basic_info_details/event_title_component.dart';
import '../../../components/basic_info_details/event_type_category.dart';
import '../../../components/basic_info_details/event_venue.dart';
import '../../../components/inside_side_menu.dart';

import '../../../providers/creator/basic_info_provider.dart';
import '../../../providers/creator/details_provider.dart';
import '../../../reusable_widgets/app_bar.dart';
import '../../../reusable_widgets/image_widget.dart';

///This [BasicInfo] [StatelessWidget] has the UI of the Basic info when user submits the form
///It includes a [Drawer] for navigation where it calls the [buildDrawer] method
///it uses 2 consumers [Consumer2] for [BasicInfoFormDataProvider] and [DetailsFormDataProvider] to retrieve the data and display it
///

class BasicInfo extends StatelessWidget {
  const BasicInfo({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: buildDrawer(context),
      ),
      appBar: AppBarWidget(),
      // drawer: Drawer(),
      body: Consumer2<BasicInfoFormDataProvider, DetailsFormDataProvider>(
          builder:
              (BuildContext context, basicIfoData, detailsData, Widget? child) {
        final basicformData = basicIfoData.formData;
        final detailsfromData = detailsData.formData;

        final eventTitle = basicformData.eventTitle!; //required => never null
        final type = basicformData.type!; //has a default
        final category = basicformData.category!; //has a default
        final location = basicformData.venueLocation!; //handled

        final singleorRecurring = basicformData.singleOrRecurring;

        String formattedDateStart = '';
        String formattedDateEnd = '';
        String formattedStartTime = '';
        String formattedEndTime = '';

        if (singleorRecurring == 'Single') {
          final eventStart = basicformData.eventStart!;
          final eventEnd = basicformData.eventEnd!;
          final startTime = basicformData.startTime!;
          final endTime = basicformData.endTime!;
          formattedDateStart = eventStart.toString().substring(0, 10);
          formattedDateStart = DateFormat('E, d MMM yyyy').format(eventStart);
          formattedDateEnd = eventEnd.toString().substring(0, 10);
          formattedDateEnd = DateFormat('E, d MMM yyyy').format(eventEnd);

          formattedStartTime = DateFormat.jm()
              .format(DateTime(1, 1, 1, startTime.hour, startTime.minute));
          formattedEndTime = DateFormat.jm()
              .format(DateTime(1, 1, 1, endTime.hour, endTime.minute));
        }

        String summary = '';
        if (detailsfromData.summary != null) {
          summary = detailsfromData.summary!;
        }
        String desc = '';
        if (detailsfromData.eventDesc != null) {
          desc = detailsfromData.eventDesc!;
        }

        File? eventImage;
        bool isUploaded = false;
        if (detailsfromData.eventImage == null) {
          // user has not uploaded an image
          isUploaded = false;
        } else {
          // user has uploaded an image
          eventImage = detailsfromData.eventImage!;
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
                eventTitle: eventTitle,
                formData: basicformData,
                summary: summary,
                desc: desc,
              ),
              const SizedBox(
                height: 20,
              ),
              singleorRecurring == 'Single'
                  ? EventDateDetails(
                      formattedDateStart: formattedDateStart,
                      formattedStartTime: formattedStartTime,
                      formattedDateEnd: formattedDateEnd,
                      formattedEndTime: formattedEndTime)
                  : Text(''),
              const SizedBox(
                height: 40,
              ),
              EventVenue(location: location),
              const SizedBox(
                height: 40,
              ),
              EventTypeCategory(type: type, category: category),
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
